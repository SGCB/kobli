#!/usr/bin/perl 


# Copyright 2010-2011 Spanish Minister of Culture
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

use strict;
use CGI;
use C4::Indicators;
use C4::Context;
use C4::Output;
use C4::Auth;
use C4::Biblio;
use C4::AuthoritiesMarc;



my $input = new CGI;
my $biblionumber = $input->param('biblionumber');
my $frameworkcode = $input->param('frameworkcode');
my $authid = $input->param('authid');
my $authtypecode = $input->param('authtypecode');
my $type = $input->param('type');

my $code;
if (defined($frameworkcode)) {
    $code = $frameworkcode;
    $type = 'biblio';
} elsif (defined($authtypecode)) {
    $code = $authtypecode;
    $type = 'auth';
} elsif ($type eq 'biblio' || $type eq 'auth') {
    $code = '';
}


my ( $template, $loggedinuser, $cookie ) = get_template_and_user(
    {
        template_name   => "cataloguing/marc21_indicators.tt",
        query           => $input,
        type            => "intranet",
        authnotrequired => 0,
    }
);

unless ($type) {
    output_html_with_http_headers $input, $cookie, $template->output;
    exit;
}

# Values of indicators as filled by user
my %tagfields = ();
foreach my $var ($input->param()) {
    if ($var =~ /^tag_([0-9]{3})_indicator([12])_[0-9]+$/) {
        $tagfields{$1}{$2}{value} = $input->param($var) if (defined($input->param($var)) && $input->param($var) ne '#');
        $tagfields{$1}{$2}{field} = $var;
    }
}


# Get data from biblio
if ($biblionumber) {
    my $record = GetMarcBiblio($biblionumber);
    $template->param( title => $record->title());
} elsif ($authid) {
    my $record = GetAuthority($authid);
    $template->param( title => $record->title());
}

# Get the languages associated with indicators
my $indicatorsLanguages = GetLanguagesIndicators();

# Is our language is defined on the indicators?
my $lang;
if ($input->param('lang') && binarySearch($input->param('lang'), $indicatorsLanguages)) {
    $lang = $input->param('lang');
} elsif ($template->param('lang') && binarySearch($template->param('lang'), $indicatorsLanguages)) {
    $lang = $template->param('lang');
} elsif ($template->{'lang'} && binarySearch($template->{'lang'}, $indicatorsLanguages)) {
    $lang = $template->{'lang'};
} else {
    $lang = 'en';
}

my @INDICATORS_LOOP;
my @tagfields = keys %tagfields;


# Get predefined values for indicators on a framework, tagfields and language
my ($frameworkcodeRet, $data) = GetValuesIndicatorFrameWorkAuth($code, $type, \@tagfields, $lang);
if ($data) {
    my $tagfield;
    for $tagfield (sort keys %$data) {
        my $dataField = GetDataFieldMarc($tagfield, $code, $type);
        if (exists($tagfields{$tagfield}) || @{$data->{$tagfield}}) {
            my $hashRef = {tagfield=> $tagfield, 
                    desc => $dataField->{liblibrarian}?$dataField->{liblibrarian}:$dataField->{libopac},
                    current_value_1 => exists($tagfields{$tagfield}{1}{value})?$tagfields{$tagfield}{1}{value}:'',
                    current_value_2 => exists($tagfields{$tagfield}{2}{value})?$tagfields{$tagfield}{2}{value}:'',
                    current_field_1 => exists($tagfields{$tagfield}{1})?$tagfields{$tagfield}{1}{field}:'',
                    current_field_2 => exists($tagfields{$tagfield}{2})?$tagfields{$tagfield}{2}{field}:''};
            my @newDataField;
            for my $dataInd (@{$data->{$tagfield}}) {
                if (length($dataInd->{ind_desc}) > 50) {
                    my $i = 0;
                    my $strDesc = $dataInd->{ind_desc};
                    do {
                        my %dataIndAux = %$dataInd;
                        my $strDescPart = '';
                        my @arrDesc = split /\s+/, $strDesc;
                        while (my $word = shift @arrDesc) {
                            $strDescPart .= $word . ' ';
                            last if (length($strDescPart) >= 50);
                        }
                        $dataIndAux{desc_partial} = $strDescPart;
                        if ($i > 0) {
                            $dataIndAux{ind_value} = '#son#';
                            $dataIndAux{ind_desc} = '';
                        }
                        push @newDataField, \%dataIndAux;
                        $strDesc = join(' ', @arrDesc);
                        $i++;
                    } while (length($strDesc) > 50);
                    if ($strDesc) {
                        my %dataIndAux = %$dataInd;
                        $dataIndAux{desc_partial} = $strDesc;
                        $dataIndAux{ind_value} = '#son#';
                        $dataIndAux{ind_desc} = '';
                        push @newDataField, \%dataIndAux;
                    }
                } else {
                    push @newDataField, $dataInd;
                }
                $hashRef->{data} = \@newDataField;
            }
            push @INDICATORS_LOOP, $hashRef;
        }
    }
}

$template->param(biblionumber => $biblionumber,
                INDICATORS_LOOP => \@INDICATORS_LOOP,
                indicatorsLanguages => $indicatorsLanguages,
                code => $code,
                type => $type
        );

output_html_with_http_headers $input, $cookie, $template->output;
