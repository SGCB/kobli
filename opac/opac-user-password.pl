#!/usr/bin/perl

# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use Modern::Perl;

use CGI;
use Digest::MD5 qw( md5_base64 md5_hex );
use String::Random qw( random_string );

use C4::Auth;
use C4::Output;
use C4::Members;
use Koha::Borrower::Modifications;
use C4::Branch qw(GetBranchesLoop);

my $cgi = new CGI;
my $dbh = C4::Context->dbh;

my ( $template, $borrowernumber, $cookie ) = get_template_and_user(
    {
        template_name   => "opac-user-password.tmpl",
        type            => "opac",
        query           => $cgi,
        authnotrequired => 1,
    }
);

if ( $borrowernumber )
{
    print $cgi->redirect("/cgi-bin/koha/opac-main.pl");
    exit;
}

my $action = $cgi->param('action') || q{};
if ( $action eq q{} ) {
    $action = 'new';
}

$template->param(
    action            => $action,
    hidden            => GetHiddenFields(),
    mandatory         => GetMandatoryFields($action),
);

if ( $action eq 'create' ) {

    my %borrower = ParseCgiForBorrower($cgi);

    %borrower = DelEmptyFields(%borrower);

    my @empty_mandatory_fields = CheckMandatoryFields( \%borrower, $action );

    if (@empty_mandatory_fields) {
        $template->param(
            empty_mandatory_fields => \@empty_mandatory_fields,
            borrower               => \%borrower
        );
    }
    elsif (
        md5_base64( $cgi->param('captcha') ) ne $cgi->param('captcha_digest') )
    {
        $template->param(
            failed_captcha => 1,
            borrower       => \%borrower
        );
    }
    else {
        ( $template, $borrowernumber, $cookie ) = get_template_and_user(
            {
                template_name   => "opac-new-password-sent.tmpl",
                type            => "opac",
                query           => $cgi,
                authnotrequired => 1,
            }
        );
        $template->param( 'email' => $borrower{'email'} );

        my $password = random_string("ssssssss");
        # my $password = "vamosaver";
        
        my $sth = $dbh->prepare("SELECT borrowernumber, userid FROM borrowers WHERE email = ? HAVING COUNT(email) = 1;");
        $sth->execute($borrower{'email'});
        my $data = $sth->fetchrow_hashref;
        
        if($data->{'borrowernumber'} =~ m/\d/){     
            $sth = $dbh->prepare("UPDATE borrowers SET password = ? WHERE borrowernumber = ?;");
            $sth->execute(md5_base64($password), $data->{'borrowernumber'} );
                                                 
            # Send password email            
            my $letter = C4::Letters::GetPreparedLetter(
                module      => 'members',
                letter_code => 'OPAC_NEW_PASS',
                substitute => {password => $password,
                               userid   => $data->{'userid'},
                               admin_mail => C4::Context->preference('KohaAdminEmailAddress')},
            );

            C4::Letters::EnqueueLetter(
                {
                    letter                 => $letter,
                    message_transport_type => 'email',
                    to_address             => $borrower{'email'},
                    from_address =>
                      C4::Context->preference('KohaAdminEmailAddress'),
                }
            );
        }
    }
}
my $captcha = random_string("CCCCn");

$template->param(
    captcha        => $captcha,
    captcha_digest => md5_base64($captcha)
);

output_html_with_http_headers $cgi, $cookie, $template->output;

sub GetHiddenFields {
    my %hidden_fields;

    my $BorrowerUnwantedField =
      C4::Context->preference("PatronSelfRegistrationBorrowerUnwantedField");

    my @fields = split( /\|/, $BorrowerUnwantedField );
    foreach (@fields) {
        next unless m/\w/o;
        $hidden_fields{$_} = 1;
    }

    return \%hidden_fields;
}

sub GetMandatoryFields {
    my ($action) = @_;

    my %mandatory_fields;

    if ( $action eq 'create' || $action eq 'new' ) {
        $mandatory_fields{'email'} = 1
    }

    return \%mandatory_fields;
}

sub CheckMandatoryFields {
    my ( $borrower, $action ) = @_;

    my @empty_mandatory_fields;

    my $mandatory_fields = GetMandatoryFields($action);
    delete $mandatory_fields->{'cardnumber'};

    foreach my $key ( keys %$mandatory_fields ) {
        push( @empty_mandatory_fields, $key )
          unless ( defined( $borrower->{$key} ) && $borrower->{$key} );
    }

    return @empty_mandatory_fields;
}

sub ParseCgiForBorrower {
    my ($cgi) = @_;

    my %borrower;

    foreach ( $cgi->param ) {
        if ( $_ =~ '^borrower_' ) {
            my ($key) = substr( $_, 9 );
            $borrower{$key} = $cgi->param($_);
        }
    }

    $borrower{'dateofbirth'} =
      C4::Dates->new( $borrower{'dateofbirth'} )->output("iso")
      if ( defined( $borrower{'dateofbirth'} ) );

    return %borrower;
}

sub DelUnchangedFields {
    my ( $borrowernumber, %new_data ) = @_;

    my $current_data = GetMember( borrowernumber => $borrowernumber );

    foreach my $key ( keys %new_data ) {
        if ( $current_data->{$key} eq $new_data{$key} ) {
            delete $new_data{$key};
        }
    }

    return %new_data;
}

sub DelEmptyFields {
    my (%borrower) = @_;

    foreach my $key ( keys %borrower ) {
        delete $borrower{$key} unless $borrower{$key};
    }

    return %borrower;
}
