package C4::Indicators;

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
use warnings;
use C4::Context;
use C4::Debug;


use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

BEGIN {
    $VERSION = 3.02;    # set version for version checking
    require Exporter;
    @ISA    = qw(Exporter);
    @EXPORT = qw(
      &GetFrameworksInd
      &GetAuthtypeInd
      &CloneIndicatorsFrameworkAuth
      &GetIndicatorsFrameworkAuth
      &DelIndicatorsFrameworkAuth
      &HasFieldMarcInd
      &GetDataFieldMarc
      &GetIndicator
      &AddIndicator
      &DelIndicator
      &AddIndicatorValue
      &DelIndicatorValue
      &ModIndicatorValue
      &ModIndicatorDesc
      &GetValuesIndicator
      &GetValuesIndicatorFrameWorkAuth
      &GetLanguagesIndicators
      &binarySearch
      &CheckValueIndicatorsSub
    );
}

=head1 NAME

C4::Indicators - Indicators Module Functions

=head1 SYNOPSIS

  use C4::Indicators;

=head1 DESCRIPTION

Module to manage indicators on intranet cataloguing section

Module to manage indicators on the intranet cataloguing section
applying the rules of MARC21 according to the Library of Congress
http://www.loc.gov/marc/bibliographic/ecbdhome.html

Functions for handling MARC21 indicators on cataloguing.


=head1 SUBROUTINES




=head2 GetFrameworksInd

Returns information about existing frameworks with indicators

=cut

sub GetFrameworksInd
{

    my $frameworkcode = shift;

    my @frameworks;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $sth = $dbh->prepare("SELECT b.* FROM biblio_framework b , marc_indicators i WHERE b.frameworkcode<>? AND b.frameworkcode=i.frameworkcode AND i.authtypecode IS NULL GROUP BY frameworkcode");
            $sth->execute($frameworkcode);
            while ( my $iter = $sth->fetchrow_hashref ) {
                push @frameworks, $iter;
            }
        };
    }
    return ( \@frameworks );
}#GetFrameworksInd


=head2 GetAuthtypeInd

Returns information about existing Auth type with indicators

=cut

sub GetAuthtypeInd
{

    my $authtypecode = shift;

    my @authtypes;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $sth = $dbh->prepare("SELECT a.* FROM auth_types a , marc_indicators i WHERE a.authtypecode<>? AND a.authtypecode=i.authtypecode AND i.frameworkcode IS NULL GROUP BY authtypecode");
            $sth->execute($authtypecode);
            while ( my $iter = $sth->fetchrow_hashref ) {
                push @authtypes, $iter;
            }
        };
    }
    return ( \@authtypes );
}#GetAuthtypeInd



=head2 CloneIndicatorsFrameworkAuth

Clone all the indicators from one framework/authtype to another one

return :
the new frameworkcode

=cut


sub CloneIndicatorsFrameworkAuth
{
    my ($codeSource, $codeDest, $type) = @_;

    my $indicators = GetIndicatorsFrameworkAuth($codeSource, $type);
    my $hashRefSource;
    my ($id_indicator, $id_indicator_value);
    for $hashRefSource (@$indicators) {
        if (GetDataFieldMarc($hashRefSource->{tagfield}, $codeDest, $type)) {
            $id_indicator = AddIndicator($hashRefSource->{tagfield}, $codeDest, $type);
            if ($id_indicator) {
                my ($id_indicator_old, $data) = GetValuesIndicator($hashRefSource->{id_indicator}, $hashRefSource->{tagfield}, $codeSource, $type);
                for (@$data) {
                    $id_indicator_value = AddIndicatorValue($id_indicator, $hashRefSource->{tagfield}, $codeDest, $type, $_->{ind}, $_->{ind_value}, $_->{ind_desc}, $_->{lang});
                }
            }
        }
    }
    return $codeDest;
}#CloneIndicatorsFrameworkAuth



=head2 GetIndicatorsFrameworkAuth

Get all the indicators from a framework/authtype

return :
an array of hash data

=cut


sub GetIndicatorsFrameworkAuth
{
    my ($code, $type) = @_;

    my @data;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = ($type eq 'biblio')?qq|SELECT id_indicator, tagfield FROM marc_indicators WHERE frameworkcode=?|:qq|SELECT id_indicator, tagfield FROM marc_indicators WHERE authtypecode=?|;
            my $sth = $dbh->prepare($query);
            $sth->execute($code);
            my $hashRef;
            while ($hashRef = $sth->fetchrow_hashref) {
                push @data, $hashRef;
            }
        };
        if ($@) {
            $debug and warn "Error GetIndicatorsFrameworkAuth $@\n";
        }
    }
    return \@data;
}#GetIndicatorsFrameworkAuth



=head2 DelIndicatorsFrameworkAuth

Delete indicators in a specific framework/authtype

return :
the success of the operation

=cut


sub DelIndicatorsFrameworkAuth
{
    my ($code, $type) = @_;

    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = ($type eq 'auth')?qq|DELETE FROM marc_indicators
                WHERE authtypecode=?|:qq|DELETE FROM marc_indicators
                WHERE frameworkcode=?|;
            my $sth = $dbh->prepare($query);
            $sth->execute($code);
        };
        if ($@) {
            $debug and warn "Error DelIndicatorsFrameworkAuth $@\n";
        } else {
            return 1;
        }
    }
    return 0;
}#DelIndicatorsFrameworkAuth



=head2 HasFieldMarc

Know if has any tag structure a specific framework

return :
number of marc tag fields

=cut


sub HasFieldMarcInd
{
    my ($code, $type) = @_;

    my $ret = 0;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = ($type eq 'biblio')?qq|SELECT COUNT(*) FROM marc_tag_structure
                WHERE frameworkcode=? AND tagfield NOT LIKE '00%'|:qq|SELECT COUNT(*) FROM auth_tag_structure
                WHERE authtypecode=? AND tagfield NOT LIKE '00%'|;
            my $sth = $dbh->prepare($query);
            $sth->execute($code);
            ($ret) = $sth->fetchrow;
            
        };
        if ($@) {
            $debug and warn "Error HasFieldMarc $@\n";
        }
    }
    return $ret;
}#HasFieldMarcInd



=head2 GetDataFieldMarc

Get the data from marc_tag_structure/auth_tag_structure for a field in a specific framework/authtype

return :
the data hash for the datafield

=cut


sub GetDataFieldMarc
{
    my ($tagfield, $code, $type) = @_;

    my $data = {};
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = ($type eq 'auth')?qq|SELECT tagfield,liblibrarian,libopac,mandatory,repeatable 
                            FROM auth_tag_structure 
                            WHERE authtypecode=? AND tagfield=?|:qq|SELECT tagfield,liblibrarian,libopac,mandatory,repeatable 
                            FROM marc_tag_structure 
                            WHERE frameworkcode=? AND tagfield=?|;
            my $sth = $dbh->prepare($query);
            $sth->execute($code, $tagfield);
            $data = $sth->fetchrow_hashref;
        };
        if ($@) {
            $debug and warn "Error GetDataFieldMarc $@\n";
        }
    }
    return $data;
}#GetDataFieldMarc



=head2 GetIndicator

Get the indicator id from a field in a specific framework/authtype

return :
the id of this indicator

=cut


sub GetIndicator
{
    my ($tagfield, $code, $type) = @_;

    my $id_indicator;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query;
            my $sth;
            if ($code) {
                $query = ($type eq 'auth')?qq|SELECT id_indicator
                    FROM marc_indicators
                    WHERE tagfield=? AND authtypecode=?|:qq|SELECT id_indicator
                    FROM marc_indicators
                    WHERE tagfield=? AND frameworkcode=?|;
                $sth = $dbh->prepare($query);
                $sth->execute($tagfield, $code);
            } else {
                $query = ($type eq 'auth')?qq|SELECT id_indicator
                    FROM marc_indicators
                    WHERE tagfield=? AND authtypecode=''|:qq|SELECT id_indicator
                    FROM marc_indicators
                    WHERE tagfield=? AND frameworkcode=''|;
                $sth = $dbh->prepare($query);
                $sth->execute($tagfield);
            }
            ($id_indicator) = $sth->fetchrow;
        };
        if ($@) {
            $debug and warn "Error GetIndicator $@\n";
        }
    }
    return $id_indicator;
}#GetIndicator



=head2 AddIndicator

Adds a new indicator to a field in a specific framework/authtype

return :
the id of this new indicator

=cut


sub AddIndicator
{
    my ($tagfield, $code, $type) = @_;

    my $id_indicator;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = ($type eq 'auth')?qq|INSERT INTO marc_indicators
                (tagfield,authtypecode) VALUES (?,?)|:qq|INSERT INTO marc_indicators
                (tagfield,frameworkcode) VALUES (?,?)|;
            my $sth = $dbh->prepare($query);
            $sth->execute($tagfield, $code);
            if ($sth->rows > 0) {
                $id_indicator = $dbh->{'mysql_insertid'};
            }
        };
        if ($@) {
            $debug and warn "Error AddIndicator $@\n";
        }
    }
    return $id_indicator;
}#AddIndicator



=head2 DelIndicator

Delete a new indicator to a field in a specific framework/authtype

return :
the success of the operation

=cut


sub DelIndicator
{
    my ($id_indicator, $tagfield, $code, $type) = @_;

    my $ret;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query;
            my @arrParams;
            if ($id_indicator){
                $query = qq|DELETE FROM marc_indicators
                WHERE id_indicator=?|;
                push @arrParams, $id_indicator;
            } else {
                $query = ($type eq 'biblio')?qq|DELETE FROM marc_indicators
                WHERE tagfield=? AND frameworkcode=?|:qq|DELETE FROM marc_indicators
                WHERE tagfield=? AND authtypecode=?|;
                @arrParams = ($tagfield, $code);
            }
            my $sth = $dbh->prepare($query);
            $sth->execute(@arrParams);
            $ret = 1;
        };
        if ($@) {
            $debug and warn "Error DelIndicator $@\n";
        }
    }
    return $ret;
}#DelIndicator



=head2 AddIndicatorValue

Adds a new indicator value and (if defined) description to a field in a specific framework/authtype

return :
the id of this new indicator value

=cut


sub AddIndicatorValue
{
    my ($id_indicator, $tagfield, $code, $type, $index, $value, $desc, $lang) = @_;

    my $id_indicator_value;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        $id_indicator = GetIndicator($tagfield, $code, $type) unless ($id_indicator);
        $id_indicator = AddIndicator($tagfield, $code, $type) unless ($id_indicator);
        eval {
            my $query = qq|INSERT INTO marc_indicators_value
                (id_indicator,ind,ind_value) VALUES (?,?,?)|;
            my $sth = $dbh->prepare($query);
            $sth->execute($id_indicator, $index, $value);
            if ($sth->rows > 0) {
                $id_indicator_value = $dbh->{'mysql_insertid'};
                if ($id_indicator_value && $desc) {
                    $query = qq|INSERT INTO marc_indicators_desc 
                        (id_indicator_value,lang,ind_desc) VALUES (?,?,?)|;
                    $lang = 'en' unless ($lang);
                    my $sth2 = $dbh->prepare($query);
                    $sth2->execute($id_indicator_value, $lang, $desc);
                }
            }
        };
        if ($@) {
            #print $@;
            $debug and warn "Error AddIndicatorValue $@\n";
        }
    }
    return $id_indicator_value;
}#AddIndicatorValue



=head2 DelIndicatorValue

Delete a new indicator value in a framework field

return :
the success of the operation

=cut


sub DelIndicatorValue
{
    my ($id_indicator_value) = @_;

    my $ret;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = qq|DELETE FROM marc_indicators_value
                WHERE id_indicator_value=?|;
            my $sth = $dbh->prepare($query);
            $sth->execute($id_indicator_value);
            $ret = 1;
        };
        if ($@) {
            $debug and warn "Error DelIndicatorValue $@\n";
        }
    }
    return $ret;
}#DelIndicatorValue



=head2 ModIndicatorValue

Modify a indicator value in a framework field

return :
the success of the operation

=cut


sub ModIndicatorValue
{
    my ($id_indicator_value, $value, $desc, $lang, $ind) = @_;

    my $ret;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = qq|UPDATE marc_indicators_value
                SET ind_value=?, ind=?
                WHERE id_indicator_value=?|;
            my $sth = $dbh->prepare($query);
            $sth->execute($value, $ind, $id_indicator_value);
            if ($desc) {
                $ret = ModIndicatorDesc($id_indicator_value, $desc, $lang);
            } else {
                $ret = 1;
            }
        };
        if ($@) {
            $debug and warn "Error ModIndicatorValue $@\n";
        }
    }
    return $ret;
}#ModIndicatorValue



=head2 ModIndicatorDesc

Modify a indicator description in a framework field and language

return :
the success of the operation

=cut


sub ModIndicatorDesc
{
    my ($id_indicator_value, $desc, $lang) = @_;

    my $ret;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = qq|SELECT COUNT(*) FROM marc_indicators_desc
                WHERE id_indicator_value=? AND lang=?|;
            my $sth = $dbh->prepare($query);
            $sth->execute($id_indicator_value, $lang);
            my ($num) = $sth->fetchrow;
            $sth->finish;
            if ($num) {
                $query = qq|UPDATE marc_indicators_desc
                SET ind_desc=?
                WHERE id_indicator_value=? AND lang=?|;
                $sth = $dbh->prepare($query);
                $sth->execute($desc, $id_indicator_value, $lang);
            } else {
                $query = qq|INSERT INTO marc_indicators_desc 
                        (id_indicator_value,lang,ind_desc) VALUES (?,?,?)|;
                $sth = $dbh->prepare($query);
                $sth->execute($id_indicator_value, $lang, $desc);
            }
            $ret = 1;
        };
        if ($@) {
            $debug and warn "Error ModIndicatorDesc $@\n";
        }
    }
    return $ret;
}#ModIndicatorDesc



=head2 GetValuesIndicator

Get distinct values and descriptions from framework/authtype field

return :
the id of the indicator and an array structure with the data required

=cut


sub GetValuesIndicator
{
    my ($id_indicator, $tagfield, $code, $type, $lang) = @_;

    my @data;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        $id_indicator = GetIndicator($tagfield, $code, $type) unless ($id_indicator);
        if ($id_indicator) {
            eval {
                my $query;
                my $sth;
                if ($lang) {
                    $query = qq|(SELECT v.id_indicator_value, v.ind, v.ind_value, d.ind_desc, d.lang
                            FROM marc_indicators_value v, marc_indicators_desc d
                            WHERE v.id_indicator=? AND d.id_indicator_value=v.id_indicator_value AND d.lang=?
                            )
                    UNION
                        (SELECT v.id_indicator_value, v.ind, v.ind_value, NULL AS ind_desc, NULL AS lang
                            FROM marc_indicators_value v
                            WHERE v.id_indicator=? AND NOT EXISTS (SELECT d.* FROM marc_indicators_desc d WHERE d.id_indicator_value=v.id_indicator_value))
                        ORDER BY ind, ind_value|;
                    $sth = $dbh->prepare($query);
                    $sth->execute($id_indicator, $lang, $id_indicator);
                } else {
                    $query = qq|SELECT v.id_indicator_value, v.ind, v.ind_value, d.ind_desc, d.lang
                        FROM marc_indicators_value v
                        LEFT JOIN marc_indicators_desc d ON d.id_indicator_value=v.id_indicator_value
                        WHERE v.id_indicator=?
                        ORDER BY v.ind, v.ind_value|;
                    $sth = $dbh->prepare($query);
                    $sth->execute($id_indicator);
                }
                while (my $hashRef = $sth->fetchrow_hashref) {
                    push @data, $hashRef;
                }
            };
            if ($@) {
                $debug and warn "Error GetValuesIndicator $@\n";
            }
        }
    }
    return ($id_indicator, \@data);
}#GetValuesIndicator



=head2 GetValuesIndicatorFrameWorkAuth

Get distinct values and descriptions from framework/authtype template

return :
the frameworkcode/authtypecode and an hash structure with the data required

=cut


sub GetValuesIndicatorFrameWorkAuth
{
    my ($code, $type, $tagfieldsArrRef, $lang) = @_;

    my %data;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        unless ($tagfieldsArrRef && @$tagfieldsArrRef) {
            $tagfieldsArrRef = [];
            eval {
                my $query;
                my $sth;
                if ($code) {
                    $query = ($type eq 'auth')?qq|SELECT tagfield FROM auth_tag_structure
                        WHERE tagfield NOT LIKE '00%' AND authtypecode=?|:qq|SELECT tagfield FROM marc_tag_structure
                        WHERE tagfield NOT LIKE '00%' AND frameworkcode=?|;
                    $sth = $dbh->prepare($query);
                    $sth->execute($code);
                } else {
                    $query = ($type eq 'auth')?qq|SELECT tagfield FROM auth_tag_structure
                        WHERE tagfield NOT LIKE '00%' AND authtypecode=''|:qq|SELECT tagfield FROM marc_tag_structure
                        WHERE tagfield NOT LIKE '00%' AND frameworkcode=''|;
                    $sth = $dbh->prepare($query);
                    $sth->execute();
                }
                my $tagfield;
                while (($tagfield) = $sth->fetchrow) {
                    push @$tagfieldsArrRef, $tagfield;
                }
            };
        }
        for (@$tagfieldsArrRef) {
            my ($id_indicator, $dataInd) = GetValuesIndicator(undef, $_, $code, $type, $lang);
            $data{$_} = $dataInd;
        }
        if ($@) {
            $debug and warn "Error GetValuesIndicatorFrameWork $@\n";
        }
    }
    return ($code, \%data);
}#GetValuesIndicatorFrameWorkAuth



=head2 GetLanguagesIndicators

Get distinct languages from indicators descriptions

return :
the languages as a sorted array

=cut


sub GetLanguagesIndicators
{
    my @languages;
    my $dbh = C4::Context->dbh;
    if ($dbh) {
        eval {
            my $query = qq|SELECT DISTINCT lang FROM marc_indicators_desc ORDER BY lang|;
            my $sth = $dbh->prepare($query);
            $sth->execute();
            my $lang;
            while (($lang) = $sth->fetchrow) {
                push @languages, $lang;
            }
        };
        if ($@) {
            $debug and warn "Error GetLanguagesIndicators $@\n";
        }
    }
    return \@languages;
}#GetLanguagesIndicators



=head2 binarySearch

Little binary search for strings

return :
true or false

=cut


sub binarySearch
{
    my ($id, $arr) = @_;

    if ($arr && @$arr) {
        my $i = 0;
        my $j = scalar(@$arr) - 1;
        my $k = 0;
        while ($arr->[$k] ne $id && $j >= $i) {
            $k = int(($i + $j) / 2);
            if ($id gt $arr->[$k]) {
                $i = $k + 1;
            } else {
                $j = $k - 1;
            }
        }
        return 0 if ($arr->[$k] ne $id);
        return 1;
    }
    return 0;
}#binarySearch



=head2 CheckValueIndicators

Check the validity ot the indicators form values against the user defined ones

return :
Hash with the indicators with wrong values

=cut


sub CheckValueIndicatorsSub
{
    my ($input, $code, $type, $langParam) = @_;

    my $retHash;
    my $lang;
    my $indicatorsLanguages = GetLanguagesIndicators();
    if ($langParam && binarySearch($langParam, $indicatorsLanguages)) {
        $lang = $langParam;
    } elsif ($input->param('lang') && binarySearch($input->param('lang'), $indicatorsLanguages)) {
        $lang = $input->param('lang');
    } else {
        $lang = 'en';
    }
    my ($codeRet, $data) = GetValuesIndicatorFrameWorkAuth($code, $type, undef, $lang);
    if ($data) {
        $retHash = {};
        my $tagfield;
        my $ind;
        my $var;
        my $random;
        my $found;
        my $nonEmptySubfield;
        my $pattern;
        my $hasIndicator = 0;
        my @params = $input->param();
        foreach $var (@params) {
            if ($var =~ /^tag_([0-9]{3})_indicator([12])_([0-9]+)$/) {
                $tagfield = $1;
                $ind = $2;
                $random = '[0-9_]*(?:' . $3 . ')?';
                if ($data->{$tagfield} && @{$data->{$tagfield}}) {
                    $hasIndicator = 0;
                    # check if exists this indicator in the framework
                    for (@{$data->{$tagfield}}) {
                        if ($ind == $_->{ind}) {
                            $hasIndicator = 1;
                            last;
                        }
                    }
                    next unless ($hasIndicator);
                    $found = 0;
                    # look for some subfield filled and if so check indicator
                    $nonEmptySubfield = 0;
                    $pattern = 'tag_' . $tagfield . '_subfield_[a-z0-9]_' . $random;
                    foreach my $value (@params) {
                        if ($value =~ /^$pattern/ && $input->param($value) ne '') {
                            $nonEmptySubfield = 1;
                            last;
                        }
                    }
                    # check if exists the value for the indicator
                    if ($nonEmptySubfield) {
                        for (@{$data->{$tagfield}}) {
                            if ($ind == $_->{ind} && ($_->{ind_value} eq $input->param($var) || $input->param($var) eq '' || $input->param($var) eq ' ')) {
                                $found = 1;
                                last;
                            }
                        }
                        # incorrect value
                        $retHash->{$tagfield}->{$ind} = $input->param($var) unless ($found);
                    }
                }
            }
        }
        $retHash = undef unless (scalar(keys %$retHash));
    }
    return $retHash;
}#CheckValueIndicatorsSub




1;
__END__

=head1 AUTHOR

Koha Development Team <http://koha-community.org/>

=cut

