#!/usr/bin/perl -w


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
use XML::LibXML;
use CGI;
use C4::Indicators;
use IO::Handle;


my $cgi = new CGI;
my $strXml = '';
my $doc;
my $root;

eval {
    $doc = XML::LibXML::Document->new('1.0', 'UTF-8');
};
if ($@) {
    $doc = undef;
    $strXml = '<?xml version="1.0" encoding="UTF-8"?>' . chr(10);
}

if ($cgi->request_method() eq "POST" || $cgi->request_method() eq "GET") {

    my $code = $cgi->param('code');
    my $type = $cgi->param('type');
    if ($doc) {
        $root = $doc->createElement('Framework');
        $root->setAttribute('frameworkcode', $code);
        $doc->addChild($root);
    } else {
        $strXml .= '<Framework frameworkcode="' . $code . '">' . chr(10);
    }

    my $params = $cgi->Vars;
    my @tagfields;
    @tagfields = split("\0", $params->{'tagfields'}) if $params->{'tagfields'};

    my $indicatorsLanguages = GetLanguagesIndicators();
    my $lang;
    if ($cgi->param('lang') && binarySearch($cgi->param('lang'), $indicatorsLanguages)) {
        $lang = $cgi->param('lang');
    } else {
        $lang = 'en';
    }

    my ($frameworkcodeRet, $data) = GetValuesIndicatorFrameWorkAuth($code, $type, \@tagfields, $lang);
    if ($data) {
        my $elementFields;
        if ($doc) {
            $elementFields = $doc->createElement('Fields');
            $root->addChild($elementFields);
        } else {
            $strXml .= '<Fields>' . chr(10);
        }
        my $tagfield;
        my $elementField;
        for $tagfield (sort keys %$data) {
            if ($doc) {
                $elementField = $doc->createElement('Field');
                $elementField->setAttribute('tag', $tagfield);
                $elementFields->addChild($elementField);
            } else {
                $strXml .= '<Field tag="' . $tagfield . '">' . chr(10);
            }
            if (@{$data->{$tagfield}}) {
                my $elementInd;
                my $dataUnique = {};
                for (@{$data->{$tagfield}}) {
                    unless (exists($dataUnique->{$_->{ind}}->{$_->{ind_value}})) {
                        $dataUnique->{$_->{ind}}->{$_->{ind_value}} = 1;
                        if ($doc) {
                            $elementInd = $doc->createElement('Indicator');
                            $elementInd->setAttribute('ind', $_->{ind});
                            $elementInd->appendText($_->{ind_value});
                            $elementField->addChild($elementInd);
                        } else {
                            $strXml .= '<Indicator ind="' . $_->{ind} . '">' . $_->{ind_value} . '</Indicator>' . chr(10);
                        }
                    }
                }
            }
            $strXml .= '</Field>' . chr(10) unless ($doc);
        }
        $strXml .= '</Fields>' . chr(10) unless ($doc);
    }
    $strXml .= '</Framework>';
} else {
    if ($doc) {
        $root = $doc->createElement('Error');
        $doc->addChild($root);
    } else {
        $strXml .= '<Error />' . chr(10);
    }
}
if ($doc) {
    $strXml = $doc->toString(0);
}
STDOUT->autoflush(1);
print "Content-type: application/xml\n\n";
print $strXml;
close(STDOUT);
exit;
