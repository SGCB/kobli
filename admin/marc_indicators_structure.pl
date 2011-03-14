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



my $input = new CGI;

my ( $template, $borrowernumber, $cookie ) = get_template_and_user(
    {
        template_name   => "admin/marc_indicators_structure.tt",
        query           => $input,
        type            => "intranet",
        authnotrequired => 0,
        flagsrequired   => { parameters => 1 },
        debug           => 1,
    }
);

my $frameworkcode = $input->param('frameworkcode');
my $authtypecode = $input->param('authtypecode');
my $op = $input->param('op');
my $tagfield = $input->param('tagfield');

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

my $dataInd;
my $id_indicator;
my $strError = '';
my ($code, $type);
if (defined($frameworkcode)) {
    $code = $frameworkcode;
    $type = 'biblio';
} elsif (defined($authtypecode)) {
    $code = $authtypecode;
    $type = 'auth';
} else {
    print $input->redirect($input->referer());
    exit;
}

if ($input->request_method() eq "GET") {
    if ($op eq 'mod') {
        ($id_indicator, $dataInd) = GetValuesIndicator(undef, $tagfield, $code, $type, $lang);
    } else {
        $op = 'add';
    }
} elsif ($input->request_method() eq "POST") {
    if ($op eq 'add') {
        my $inserted = 0;
        $id_indicator = AddIndicator($tagfield, $code, $type);
        if ($id_indicator) {
            $inserted++;
            my $id_indicator_value;
            my $counter;
            for ($input->param()) {
                if ($_ =~ /^ind_value_([0-9]+)$/ && ($counter = $1) && $input->param('ind_' . $counter) =~ /^([12])$/) {
                    $id_indicator_value = AddIndicatorValue($id_indicator, $tagfield, $code, $type, $1, $input->param($_), $input->param('ind_desc_' . $counter), $lang);
                    $inserted++ if ($id_indicator_value);
                }
            }
        }
        if ($inserted) {
            $op = 'mod';
            $strError = 'Insertion OK';
            ($id_indicator, $dataInd) = GetValuesIndicator($id_indicator, $tagfield, $code, $type, $lang);
        } else {
            $strError = 'Insertion failed';
        }
    } elsif ($op eq 'mod') {
        $id_indicator = $input->param('id_indicator');
        ($id_indicator, $dataInd) = GetValuesIndicator($id_indicator, $tagfield, $code, $type, $lang);
        my $indRepeated = {};
        my $indId = {};
        my $id_indicator_value;
        my $counter;
        for ($input->param()) {
            if ($_ =~ /^id_indicator_([0-9]+)$/ && ($counter = $1) && $input->param('ind_' . $counter) =~ /^([12])$/) {
                $indRepeated->{$counter} = $input->param($_);
                $indId->{$input->param($_)} = $input->param($_);
                ModIndicatorValue($input->param($_), $input->param('ind_value_' . $counter), $input->param('ind_desc_' . $counter), $lang, $input->param('ind_' . $counter));
            } elsif ($_ =~ /^ind_value_([0-9]+)$/ && ($counter = $1) && !exists($indRepeated->{$counter}) && $input->param('ind_' . $counter) =~ /^([12])$/) {
                $id_indicator_value = AddIndicatorValue($id_indicator, $tagfield, $code, $type, $1, $input->param($_), $input->param('ind_desc_' . $counter), $lang);
                $indId->{$id_indicator_value} = $id_indicator_value if ($id_indicator_value);
            }
        }
        foreach (@$dataInd) {
            unless (exists($indId->{$_->{id_indicator_value}})) {
                DelIndicatorValue($_->{id_indicator_value});
                $id_indicator_value = $_->{id_contenido};
            }
        }
        unless ($id_indicator_value) {
            $strError = 'Update OK.';
        } else {
            $strError = 'Update failed.';
        }
        @$dataInd = undef;
        ($id_indicator, $dataInd) = GetValuesIndicator($id_indicator, $tagfield, $code, $type, $lang);
        DelIndicator($id_indicator, $tagfield, $code, $type) unless (@$dataInd);
    }
}


if ($dataInd) {
    my $i = 1;
    for (@$dataInd) {
        $_->{numInd} = $i;
        $i++;
    }
}


$template->param(code => $code,
            type => $type,
            strError => $strError,
            op => $op,
            lang => $lang,
            tagfield => $tagfield,
            numInd => ($dataInd)?scalar(@$dataInd):0,
            BIG_LOOP => $dataInd,
);


output_html_with_http_headers $input, $cookie, $template->output;
