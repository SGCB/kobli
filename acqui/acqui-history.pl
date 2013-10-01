#!/usr/bin/perl

# Copyright 2013 Ministerio de Educación Cutura y Deporte, Masmedios, Nuño López Ansótegui
#
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

=head1 acquisitions/acqui-history.pl

script to show Branch acquisitions history
 This software is placed under the gnu General Public License, v2 (http://www.gnu.org/licenses/gpl.html)

=cut

## modules
use strict;
#use warnings; FIXME - Bug 2505
use CGI qw/-utf8/;
use List::Util qw/min/;
use C4::Context;
use C4::Auth qw/:DEFAULT get_session/;
use C4::Output;
use C4::Debug;
use C4::Reports::Guided;
use CGI qw/-utf8/;
use C4::Members;
use C4::Branch;

my $dbh = C4::Context->dbh;

my $input       = new CGI;

my $flagsrequired = 'execute_reports';

my ($template, $loggedinuser, $cookie, $staff_flags ) = get_template_and_user(
	{   template_name   => "acqui/acqui-history.tmpl",
        query           => $input,
        type            => "intranet",
        authnotrequired => 0,
        flagsrequired   => { reports => $flagsrequired },
        debug           => 1,
	}
);
my $session = $cookie ? get_session($cookie->value) : undef;

    my $limit      = 20;
    # my $offset     = 0;

    $template->param(
        'limit'   => $limit,
    );
    
    my $user = GetMember( 'borrowernumber' => $loggedinuser );
    
    my $branch   = C4::Context->userenv->{'branch'} ;

    my ( $sql, $type, $name, $notes );
        $sql   = q|SELECT bi.biblionumber, title, author, budget_branchcode, itemtype, isbn, issn, budget_name
            FROM biblio bi, aqorders aqo, aqbudgets aqb, biblioitems bl
            WHERE aqo.budget_id = aqb.budget_id
            AND bi.biblionumber = aqo.biblionumber
            AND bl.biblionumber = bi.biblionumber
            AND budget_branchcode = '|.$branch.q|' 
            ORDER BY bi.biblionumber;|;
        $name  = "nombre";
        $notes = "notas";
        
        my $library = GetBranchName($branch);

        my @rows = ();
        my @split = split /<<|>>/,$sql;
        # my @tmpl_parameters;
        # my ($sth, $errors) = execute_query($sql, $offset, $limit);
        my $sth = $dbh->prepare($sql);
        $sth->execute();
        my $total = nb_rows($sql) || 0;
        my $headers= header_cell_loop($sth);
        $template->param(header_row => $headers);
        while (my $row = $sth->fetchrow_arrayref()) {
            my @cells = map { +{ cell => $_ } } @$row;
            push @rows, { cells => \@cells };
        }

        my $totpages = int($total/$limit) + (($total % $limit) > 0 ? 1 : 0);
        my $url = "/cgi-bin/koha/acqui/acqui-history";
        $template->param(
            'results' => \@rows,
            'sql'     => $sql,
            'execute' => 1,
            'name'    => $name,
            'notes'   => $notes,
            'pagination_bar'  => pagination_bar($url, $totpages, $input->param('page')),
            'unlimited_total' => $total,
            'library' => $library,
        );

# pass $sth, get back an array of names for the column headers
sub header_cell_values {
    my $sth = shift or return ();
    my @cols;
    foreach my $c (@{$sth->{NAME}}) {
        #FIXME apparently DBI still needs a utf8 fix for this?
        utf8::decode($c);
        push @cols, $c;
    }
    return @cols;
}

# pass $sth, get back a TMPL_LOOP-able set of names for the column headers
sub header_cell_loop {
    my @headers = map { +{ cell => $_ } } header_cell_values (shift);
    return \@headers;
}

output_html_with_http_headers $input, $cookie, $template->output;
