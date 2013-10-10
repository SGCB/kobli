#!/usr/bin/perl

# Copyright 2010-2011 MASmedios.com y Ministerio de Cultura
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
# You should have received a copy of the GNU General Public License along with
# Koha; if not, write to the Free Software Foundation, Inc., 59 Temple Place,
# Suite 330, Boston, MA  02111-1307 USA

use strict;
use warnings;

use CGI;
use C4::Auth;
use C4::Output;
use C4::Context;
use C4::Languages qw(getFrameworkLanguages getTranslatedLanguages getAllLanguages get_bidi regex_lang_subtags language_get_description accept_language);
use File::Spec;
use IO::File;
use IO::Handle;
use Locale::PO;
use FindBin qw( $Bin );
use POSIX;
use Fcntl':mode';
use Stat::lsMode; # Must be installed via CPAN
use File::Path ;

my ($dirLib, $routeLangInstaller);
BEGIN {
        my $intranetdir = C4::Context->intranetdir;
        $dirLib = ($intranetdir =~ /^(.+?)\/intranet\/cgi-bin/)?$1:$intranetdir;
        $dirLib .= '/' unless ($dirLib =~ /\/$/);
        $routeLangInstaller = $dirLib . 'misc/translator';
}

use lib $routeLangInstaller;
use LangInstaller;

our $lang;
our $selectedlang;
our $selectedPO;
our $selectedTemplate;
our $selectedSection;
our $selectedInactivelang;
our $newLangCode;
our $selectedActivelang;

sub GetLanguages
{
    my ($value, $options) = @_;
    my $current_languages = { map { +$_, 1 } split( /\s*,\s*/, $value ) };
    my $theme;
    my $interface;
    if ( $options->{'type'} eq 'opac-languages' ) {
        # this is the OPAC
        $interface = 'opac';
        $theme     = C4::Context->preference('opacthemes');
    } else {
        # this is the staff client
        $interface = 'intranet';
        $theme     = C4::Context->preference('template');
    }
    return getTranslatedLanguages( $interface, $theme, $lang, $current_languages );
}

sub GetActiveLanguages
{
        my $dbh = C4::Context->dbh;
        my %vars_intranet_language = ('pref' => 'language', 'type' => 'staff-languages');
        my %vars_opac_language = ('pref' => 'opaclanguages', 'type' => 'opac-languages');
        my @lines;
        my @chunks;
        my @names;
        my $row;
        my $value;
        my $intranet_languages;
        my $opac_languages;
        my @active_languages = ();
        # Staff active languages
        $row = $dbh->selectrow_hashref("SELECT value, type FROM systempreferences WHERE variable = ?", {}, $vars_intranet_language{'pref'});
        $value = $row->{'value'};

        $intranet_languages = GetLanguages($value, \%vars_intranet_language);
        my @array_intranet_languages = @$intranet_languages;
        foreach my $hashLanguage (@array_intranet_languages){
                if (defined($hashLanguage->{'group_enabled'}) && $hashLanguage->{'rfc4646_subtag'} ne 'en') {
                        my %language_item;
                        $language_item{'language'} = $hashLanguage->{'language'};
                        $language_item{'name'} = $hashLanguage->{'native_description'};
                        $language_item{'code'} = $hashLanguage->{'rfc4646_subtag'};
                        if ($selectedlang && $hashLanguage->{'rfc4646_subtag'} eq $selectedlang) {
                                $language_item{'selected'} = ' selected';
                        }
                        push(@active_languages, \%language_item);
                }
        }
        # Opac active languages
        $row = $dbh->selectrow_hashref("SELECT value, type FROM systempreferences WHERE variable = ?", {}, $vars_opac_language{'pref'} );
        $value = $row->{'value'};
        $opac_languages = GetLanguages($value, \%vars_opac_language);
        my @array_opac_languages = @$opac_languages;
        foreach my $hashLanguage (@array_opac_languages) {
                my $found = 0;
                foreach my $dummyHash (@active_languages) {
                        if ($dummyHash->{'code'} eq $hashLanguage->{'rfc4646_subtag'}) {
                                $found = 1;
                                last;
                        }
                }
                if (!$found) {
                        if (defined($hashLanguage->{'group_enabled'}) && $hashLanguage->{'rfc4646_subtag'} ne 'en') {
                                my %language_item;
                                $language_item{'language'} = $hashLanguage->{'language'};
                                $language_item{'name'} = $hashLanguage->{'native_description'};
                                $language_item{'code'} = $hashLanguage->{'rfc4646_subtag'};
                                if ($selectedlang && $hashLanguage->{'rfc4646_subtag'} eq $selectedlang) {
                                        $language_item{'selected'} = ' selected';
                                }
                                push(@active_languages, \%language_item);
                        }
                }
        }
        return \@active_languages;
}

sub GetPOfilenames
{
        $Bin = $routeLangInstaller; # $Bin happens to have the path to LangInstaller.pm
        my $installer = LangInstaller->new($selectedlang);
        my $POfile_pref = $installer->po_filename();
        my $POfile_opac = $installer->{path_po} . '/' . $selectedlang . $installer->{'interface'}[0]->{'suffix'};
        my $POfile_intranet = $installer->{path_po} . '/' . $selectedlang . $installer->{'interface'}[1]->{'suffix'};
        my %filenames = ('POfile_pref'=>$POfile_pref, 'POfile_opac'=>$POfile_opac, 'POfile_intranet'=>$POfile_intranet);
        return \%filenames;
}

sub ExistPOfile
{
        my $filename = shift;
        if(-e $filename) {
                # PO file exists
                return 1;
        } else {
                # PO file does not exist
                return 0;
        }
}

sub PermissionPOfile
{
        my $filename = shift;
        if(-r $filename && -w $filename) {
                # read/write permissions
                return 1;
        } else {
                # no read/write permissions
                return 0;
        }
}

sub MakeOptionsComboboxPO
{
        my $filenames = shift;
        my @PoFiles;
        my %pref_item;
        my %pref_opac;
        my %pref_intranet;

        if (ExistPOfile($filenames->{'POfile_pref'}) && PermissionPOfile($filenames->{'POfile_pref'})){
                $pref_item{'value'} = $filenames->{'POfile_pref'};
                my @dummy = split(/\//, $filenames->{'POfile_pref'});
                $pref_item{'label'} = pop(@dummy);
                if ($selectedPO && $pref_item{'value'} eq $selectedPO) {
                       $pref_item{'selected'} = ' selected';
                }
                push(@PoFiles, \%pref_item);
        }
        if (ExistPOfile($filenames->{'POfile_opac'}) && PermissionPOfile($filenames->{'POfile_opac'})){
                $pref_opac{'value'} = $filenames->{'POfile_opac'};
                my @dummy = split(/\//, $filenames->{'POfile_opac'});
                $pref_opac{'label'} = pop(@dummy);
                if ($pref_opac{'value'} eq $selectedPO) {
                       $pref_opac{'selected'} = ' selected';
                }
                push(@PoFiles, \%pref_opac);
        }
        if (ExistPOfile($filenames->{'POfile_intranet'}) && PermissionPOfile($filenames->{'POfile_intranet'})){
                $pref_intranet{'value'} = $filenames->{'POfile_intranet'};
                my @dummy = split(/\//, $filenames->{'POfile_intranet'});
                $pref_intranet{'label'} = pop(@dummy);
                if ($selectedPO && $pref_intranet{'value'} eq $selectedPO) {
                       $pref_intranet{'selected'} = ' selected';
                }
                push(@PoFiles, \%pref_intranet);
        }
        return @PoFiles;
}

sub MakePermissionsTable
{
        my $filenames = shift;
        my $tableHTML;
        if (ExistPOfile($filenames->{'POfile_pref'})){
              my $user;
              my $group;
              if ((my $dev,my $ino,my $mode,my $nlink,my $uid,my $gid,my $rdev,my $size,my $atime,my $mtime,my $ctime,my $blksize,my $blocks) = lstat($filenames->{'POfile_pref'})) {
                      $user = getpwuid($uid);
                      $group = getgrgid($gid);
              }
              my @dummy = split(/\//, $filenames->{'POfile_pref'});
              $tableHTML .= '<tr><td><b>' . pop(@dummy) . '</b></td><td>' . $user . '</td><td>' . $group . '</td>';
              $tableHTML .= '<td>' . file_mode($filenames->{'POfile_pref'}) . '</td></tr>';
        }
        if (ExistPOfile($filenames->{'POfile_opac'})){
              my $user;
              my $group;
              if ((my $dev,my $ino,my $mode,my $nlink,my $uid,my $gid,my $rdev,my $size,my $atime,my $mtime,my $ctime,my $blksize,my $blocks) = lstat($filenames->{'POfile_opac'})) {
                      $user = getpwuid($uid);
                      $group = getgrgid($gid);
              }
              my @dummy = split(/\//, $filenames->{'POfile_opac'});
              $tableHTML .= '<tr><td><b>' . pop(@dummy) . '</b></td><td>' . $user . '</td><td>' . $group . '</td>';
              $tableHTML .= '<td>' . file_mode($filenames->{'POfile_opac'}) . '</td></tr>';
        }
        if (ExistPOfile($filenames->{'POfile_intranet'})){
              my $user;
              my $group;
              if ((my $dev,my $ino,my $mode,my $nlink,my $uid,my $gid,my $rdev,my $size,my $atime,my $mtime,my $ctime,my $blksize,my $blocks) = lstat($filenames->{'POfile_intranet'})) {
                      $user = getpwuid($uid);
                      $group = getgrgid($gid);
              }
              my @dummy = split(/\//, $filenames->{'POfile_intranet'});
              $tableHTML .= '<tr><td><b>' . pop(@dummy) . '</b></td><td>' . $user . '</td><td>' . $group . '</td>';
              $tableHTML .= '<td>' . file_mode($filenames->{'POfile_intranet'}) . '</td></tr>';
        }
        return $tableHTML;
}

sub OpenPOfile
{
        return Locale::PO->load_file_asarray($selectedPO);
}

sub in_array
{
     my ($arr,$search_for) = @_;
     foreach my $value (@$arr) {
         return 1 if $value eq $search_for;
     }
     return 0;
}

sub trim
{
   my $string = shift;
   if ($string) {
        $string =~ s/^\s+|\s+$//g;
   }
   return $string;
}

sub GetTemplatesPOfile
{
     my $objectsPOe = shift;
     my @templates;
     foreach my $objPO (@$objectsPOe) {
             if ($objPO->reference) {
                     my @paths = split(/\s/, $objPO->reference);
                     foreach my $itemPath (@paths) {
                             my @reference = split(/:/, $itemPath);
                             my @path = split(/\//, $reference[0]);
                             my $filename = pop(@path);
                             if ($filename ne '' && !in_array(\@templates,$filename)) {
                                push(@templates, $filename);
                             }
                     }
             }
     }
     @templates = sort { lc $a cmp lc $b } @templates;
     return \@templates;
}

sub MakeOptionsComboboxTemplates
{
       my $templatesData = shift;
       my @Templates;
       foreach my $templ (@$templatesData) {
               my %element;
               $element{'value'} = $templ;
               $element{'label'} = $templ;
               if ($selectedTemplate && $element{'value'} eq $selectedTemplate) {
                       $element{'selected'} = ' selected';
               }
               push(@Templates, \%element);
       }
       return @Templates;
}

sub GetLabelsTemplatesPOfile
{    
     my ($objectsPOe, $selectedTemplate) = @_;
     my %labels;
     foreach my $objPO (@$objectsPOe) {
             if ($objPO->reference){
                     my @paths = split(/\s/, $objPO->reference);
                     foreach my $itemPath (@paths) {
                             my @reference = split(/:/, $itemPath);
                             my @path = split(/\//, $reference[0]);
                             my $filename = pop(@path);
                             if ($filename && $filename eq $selectedTemplate) {
                                my %msg = ("msgid"=> $objPO->dequote($objPO->msgid), "msgstr" => $objPO->dequote($objPO->msgstr), "fuzzy" => (defined($objPO->fuzzy))?$objPO->fuzzy:0, "c_format" => (defined($objPO->c_format))?$objPO->c_format:' ');
                                $labels{$objPO->loaded_line_number} = \%msg;
                             }
                     }
             }
     }
     my @sortlabels;
     for (sort {$a <=> $b} keys %labels) {
             my %dummy = ($_ => $labels{$_});
             push(@sortlabels, \%dummy);
     }
     return \@sortlabels;
}

sub GetCommentsPOfile
{
     my $objectsPOe = shift;
     my @comments;
     foreach my $objPO (@$objectsPOe) {
             if ($objPO->comment) {
                     my @sections = split(/\n/, $objPO->comment);
                     my $etiqueta = trim($sections[0]);
                     if ($etiqueta && !in_array(\@comments,$etiqueta)) {
                        push(@comments, $etiqueta);
                     }
             }
     }
     @comments = sort { lc $a cmp lc $b } @comments;
     return \@comments;
}

sub MakeOptionsComboboxSections
{
       my $sectionsData = shift;
       my @Sections;
       foreach my $templ (@$sectionsData) {
               my %element;
               $element{'value'} = $templ;
               $element{'label'} = $templ;
               if ($selectedSection && $element{'value'} eq $selectedSection) {
                       $element{'selected'} = ' selected';
               }
               push(@Sections, \%element);
       }
       return @Sections;
}

sub GetLabelsSectionsPOfile
{
     my ($objectsPOe, $selectedSection) = @_;
     my %labels;
     foreach my $objPO (@$objectsPOe) {
             if ($objPO->comment && $objPO->comment =~ /$selectedSection/) {
                 # Label of the selected section
                 my %msg = ("msgid"=> $objPO->dequote($objPO->msgid), "msgstr" => $objPO->dequote($objPO->msgstr), "fuzzy" => (defined($objPO->fuzzy))?$objPO->fuzzy:0, "c_format" => (defined($objPO->c_format))?$objPO->c_format:' ');
                 $labels{$objPO->loaded_line_number} = \%msg;
             }
     }
     my @sortlabels;
     for (sort {$a <=> $b} keys %labels) {
             my %dummy = ($_ => $labels{$_});
             push(@sortlabels, \%dummy);
     }
     return \@sortlabels;
}

sub IsRestrictedLabel
{
        my $label = shift;
        my @restrictedLabels = ('#','text/html; charset=utf-8','(%s)','(su',',complete-subfield','-- ','.png','/cgi-bin/koha/opac-search.pl?q=','/cgi-bin/koha/opac-search.pl?q=Control-number:','/cgi-bin/koha/opac-search.pl?q=Host-item:','/cgi-bin/koha/opac-search.pl?q=Title:','/cgi-bin/koha/opac-search.pl?q=an:','/cgi-bin/koha/opac-search.pl?q=au:','/cgi-bin/koha/opac-search.pl?q=rcn:','/cgi-bin/koha/opac-search.pl?q=su','/opac-tmpl/prog/famfamfam/','100,110,111,700,710,711','130,240','440,490',': ',':,;/ ',':{','; ','| ','}','})','_','(',') ','). ',', ','. ','/cgi-bin/koha/opac-detail.pl?biblionumber=','[','display:block; ','display:block; text-align:right; float:right; width:50%%; padding-left:20px','/cgi-bin/koha/opac-search.pl?q=su:','koha:biblionumber:{marc:datafield[@tag=999]/marc:subfield[@code=\'c\']}','%s&nbsp;%s %s','%s %s(%s)%s ?','%s:','&gt;&gt;','&lt;&lt;','&lt;&lt; ','%s%s, %s%s %s (%s) %s ','%s, %s%s %s (%s) %s ','- %s','ctx_ver=Z39.88-2004&rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook&rft.au=[% BIBLIO_RESULT.author %]&rft.btitle=[% BIBLIO_RESULT.title |url %]&rft.date=[% BIBLIO_RESULT.publicationyear %]&rft.tpages=[% BIBLIO_RESULT.size %]&rft.isbn=[% BIBLIO_RESULT.isbn |url %]&rft.aucorp=&rft.place=[% BIBLIO_RESULT.place %]&rft.pub=[% BIBLIO_RESULT.publisher |url %]&rft.edition=[% BIBLIO_RESULT.edition %]&rft.series=[% BIBLIO_RESULT.series %]&rft.genre=','%s %s %s %s (%s)','%s %s ; %s ','%s %s%s (','%s %s(%s)%s %s, %s%s %s%s %s %s','%s (%s)%s','%s [ %s %s %s %s %s ] %s %s, %s%s ','%s%s%s.%s; %s%s','%s%s/%s%s','%s(%s)%s %s, %s%s ',')%s%s','| %s','%s(%s)%s','[ ',']','%s%s/cgi-bin/koha/opac-MARCdetail.pl?biblionumber=%s%s%s%s/cgi-bin/koha/opac-ISBDdetail.pl?biblionumber=%s%s%s/cgi-bin/koha/opac-detail.pl?biblionumber=%s%s%s','%s/cgi-bin/koha/opac-detail.pl?biblionumber=%s','%s/cgi-bin/koha/opac-search.pl?%s%s&amp;format=atom','%s/cgi-bin/koha/opac-search.pl?%s%s&amp;format=rss2','%s %s%s%s %s %s%s%s %s[','%s - %s%s %s- %s%s %s ; %s%s %s - %s%s %s : %s%s %s ; %s%s %s ','%s&nbsp;%s ',']%s %s (%s), %s ','%s %s %s %s %s %s %s %s %s%s%s %s[','%s %s %s &nbsp;','%s&nbsp; %s ',', %s %s ','%sby ',']%s %s (%s), %s %s ','%sby %s%s','%s&nbsp; ','%s/cgi-bin/koha/opac-detail.pl?biblionumber=%s#comments','%s/cgi-bin/koha/opac-detail.pl?biblionumber=%s&amp;reviewid=%s','%s/cgi-bin/koha/opac-showreviews.pl&amp;format=rss2','%s%s%s&nbsp;%s ','%s%s%s,%s %s%s&nbsp;%s ','%s%s,%s %s - %s,%s %s - %s%s %s(%s)%s %s , %s%s %s - %s%s ','[% DEFAULT limit=','%s %s - %s%s %s- %s%s %s(%s)%s %s ; %s%s %s - %s%s %s ; %s%s','%s%s%s&nbsp;%s','%s&nbsp;%s','%s, %s, %s','%s (%s)','/ ','] ','+ ','%s %s%s %s &nbsp; %s ','%s / %s','%s: %s','$(\".tagnum a\").hide();','*','});','%s%s%s *','%s : ','. %s ','koha-conf.xml','\'%s\'?','\'%s\' (%s)','%s %s %s (%s) %s ','%s %s %s *','%ss: ','&nbsp; (','%s %s (%s)','). %s ','[% IF ( enrolmentperiod ) %][% enrolmentperiod %][% END %]','%s %s (%s) ','\'%s\'','%s %s %s%s -- %s %s %s %s%s (%s)%s ','%s %s, %s%s%s (','%s(%s)%s %s, %s%s %s%s%s %s%s%s ','%s)%s ', '%s%s, %s%s&nbsp;%s','%s %s/%s ','%s%s, %s%s (%s)','%s %s(');
        my $isRestricted = in_array(\@restrictedLabels, $label);
        if ($isRestricted) {
                return 1;
        } else {
                if ($label =~ /^\&lt;\?xml version=\\"1.0\\" encoding=\\"ISO-8859-1\\" \?\&gt; \&lt;/ || $label =~ /ctx_ver=Z39.88-2004\&amp;rft_val_fmt=/ || $label =~ /^\s*%s(?:[\s,\|\-=\.]*%s+)*\s*$/) {
                        return 1;
                } else {
                        return 0;
                }
        }
}

sub MakeFieldsLabels
{
       my $labelsData = shift;
       my @formFields;       
       foreach my $elemento (@$labelsData) {
               my %element;
               my $restricted;
               while (my ($key, $value) = each(%$elemento)){                       
                       my $msgid = $value->{'msgid'};
                       $element{'msgid'} = $msgid;
                       $restricted = IsRestrictedLabel($element{'msgid'});
                       if (!$restricted) {
                               $element{'msgid'} =~ s/&/&amp;/g;
                               $element{'msgid'} =~ s/</&lt;/g;
                               #$element{'msgid'} =~ s/\\+"/"/g;                               
                               my $msgstr = $value->{'msgstr'};
                               $element{'msgstr'} = $msgstr;                               
                               #$element{'msgstr'} =~ s/\\+"/"/g;
                               #$element{'msgstr'} =~ s/'/"/g;
                               $element{'msgstr'} =~ s/'/\\"/g;
                               $element{'fuzzy'} = $value->{'fuzzy'};
                               $element{'c_format'} = $value->{'c_format'};
                               $element{'id'} = $key;                              
                       }
               }
               
               if (!$restricted) {
                        push(@formFields, \%element);
               }
       }
       
       return @formFields;
}

sub UpdatePOLabels
{    
       my ($objectsPOe, $query) = @_;
       foreach my $paramName ($query->param) {
               if ($paramName =~ /^field_/) {
                       my @partsParamName = split(/_/, $paramName);
                       foreach my $objPO (@$objectsPOe) {
                               if ($objPO->loaded_line_number eq $partsParamName[1]) {
                                       $objPO->msgstr($query->param($paramName));                                       
                                       
                                       if ($objPO->fuzzy ne $query->param('fuzzy_' . $partsParamName[1])) {
                                           $objPO->fuzzy($query->param('fuzzy_' . $partsParamName[1]));
                                       } 
                                       if ($objPO->c_format ne $query->param('c_format_' . $partsParamName[1])) {
                                           $objPO->c_format($query->param('c_format_' . $partsParamName[1]));                                           
                                       }                                       
                                       last;
                               }
                       }
               }
       }
       # Save the changes in the PO file
       Locale::PO->save_file_fromarray($selectedPO,$objectsPOe);
}

sub GetPOLanguages
{
       my $inactive = shift;
       $Bin = $routeLangInstaller; # $Bin happens to have the path to LangInstaller.pm
       my $installer = LangInstaller->new();
       my $activeLanguages = GetActiveLanguages();
       my $dummyLang = $installer->{langs};
       my @allLanguages = @$dummyLang;
       my %hash = map { $_, 1 } @allLanguages;
       my @allLanguagesUnique = keys %hash;
       my @definedLanguages;
       # $inactive = no defined  --> Used to get all llanguages
       # $inactive = 1 --> Used to create translation
       # $inactive = 2 --> Used to update translation
       if ($inactive == 1 || $inactive == 2) {
               if ($inactive == 1) {
                       # Used to create translation
                       my @noActiveLanguages = ();
                       my $ln;
                       for $ln (@allLanguagesUnique){
                               if ($ln =~ /\S+/) {
                                       my $found = 0;
                                       # It verifies that there isn't an active language
                                       foreach my $lni (@$activeLanguages){
                                               if ($ln eq $lni->{'code'}) {
                                                       $found = 1;
                                                       last;
                                               }
                                       }
                                       if (!$found) {
                                               # It verifies that there are no established their target directories
                                               foreach my $tmpl (@{$installer->{interface}}) {
                                                       my $lang_dir = "$tmpl->{dir}/$ln";
                                                       if (-d $lang_dir){
                                                               $found = 1;
                                                               last;
                                                       }
                                               }
                                               if (!$found) {
                                                       push(@noActiveLanguages, $ln);
                                               }
                                       }
                               }
                       }
                       @definedLanguages = sort { lc $a cmp lc $b } @noActiveLanguages;
               } else {
                       # Used to update translation
                       my @ActiveLanguages = ();
                       my $ln;
                       for $ln (@allLanguagesUnique){
                               if ($ln =~ /\S+/) {
                                       my $found = 0;
                                       # It verifies that there are established their target directories
                                       foreach my $tmpl (@{$installer->{interface}}) {
                                               my $lang_dir = "$tmpl->{dir}/$ln";
                                               if (-d $lang_dir){
                                                       $found = 1;
                                                       last;
                                               }
                                       }
                                       if ($found) {
                                               push(@ActiveLanguages, $ln);
                                       }
                               }
                       }
                       @definedLanguages = sort { lc $a cmp lc $b } @ActiveLanguages;
               }
       } else {
               @definedLanguages = sort { lc $a cmp lc $b } @allLanguagesUnique;
       }
       my @Langs;
       for my $item_language (@definedLanguages) {
            my %element;
            $element{'value'} = $item_language;
            if (($inactive == 1 && $selectedInactivelang && $item_language eq $selectedInactivelang) || ($inactive == 2 && $selectedActivelang && $item_language eq $selectedActivelang) || (!$inactive && $selectedlang && $item_language eq $selectedlang)) {
                $element{'selected'} = ' selected';
            }
            my $language_subtags_hashref = regex_lang_subtags($item_language);
            if (defined(language_get_description($language_subtags_hashref->{language},'en','language'))) {
                    $element{'label'} = $item_language . ' (' . language_get_description($language_subtags_hashref->{language},'en','language') . ')';
            } else {
                    if (defined(language_get_description($language_subtags_hashref->{language},$language_subtags_hashref->{language},'language'))) {
                             $element{'label'} = $item_language . ' (' . language_get_description($language_subtags_hashref->{language},$language_subtags_hashref->{language},'language') . ')';
                    } else {
                            $element{'label'} = $item_language;
                    }
            }
            push(@Langs, \%element);
       }
       return @Langs;
}

sub WriteTemplateDirs
{
      my $tableHTML;
      $Bin = $routeLangInstaller; # $Bin happens to have the path to LangInstaller.pm
      my $error = 0;
      my $installer = LangInstaller->new();
      while (my ($interface, $tmpl) = each %{$installer->{interface}}) {
              if (!-w $tmpl->{dir}) {
                      $error = 1; # No write permissions
              }
      }
      if ($error) {
              # Return table with directories permissions information
              while (my ($interface, $tmpl) = each %{$installer->{interface}}) {
                      my $user;
                      my $group;
                      if ((my $dev,my $ino,my $mode,my $nlink,my $uid,my $gid,my $rdev,my $size,my $atime,my $mtime,my $ctime,my $blksize,my $blocks) = lstat($tmpl->{dir})) {
                              $user = getpwuid($uid);
                              $group = getgrgid($gid);
                      }
                      $tableHTML .= '<tr><td><b>' . $tmpl->{dir} . '</b></td><td>' . $user . '</td><td>' . $group . '</td>';
                      $tableHTML .= '<td>' . file_mode($tmpl->{dir}) . '</td></tr>';
              }
      } else {
              $tableHTML = '';
      }
      return $tableHTML;
}

sub system_capture
# Executes a system command, and when it is finished, returns the result code,
# standard output, and error output.
# Arguments: [0] command to be executed.
# Returns a list containing:
#   [0] the command's return code
#   [1] the standard output
#   [2] the error output
# Any redirection specifiers contained in the command will be ignored.
{
  use File::Temp qw(tempfile);
  my(undef,$out)=tempfile(dir=>$ENV{tmp},suffix=>'.tmp');
  my(undef,$err)=tempfile(dir=>$ENV{tmp},suffix=>'.tmp');
  my $rc=system("$_[0] 1>$out 2>$err");
  my $outtext;
  my $errtext;
  if(open(F,"<$out"))
  {
    while(<F>){$outtext.=$_}
    close F;
  }
  if(open(F,"<$err"))
  {
    while(<F>){$errtext.=$_}
    close F;
  }
  return($rc,$outtext,$errtext);
}

sub CreateTranslationInactiveLang
{
      my %dataExecution;
      my $langCode = shift;
      # It verifies that there are no directories
      $Bin = $routeLangInstaller; # $Bin happens to have the path to LangInstaller.pm
      my $installer = LangInstaller->new($langCode);
      my $existe = 0;
      while (my ($interface, $tmpl) = each %{$installer->{interface}}) {
              my $lang_dir = "$tmpl->{dir}/$installer->{lang}";
              if (-d $lang_dir) {
                      $existe = 1;
                      last;
              }
      }
      if ($existe) {
              $dataExecution{'code'} = 0;
      } else {
        # Installation of new language
        my $execution = "cd $routeLangInstaller;perl ./translate install $langCode";
        my @printResponse = system_capture($execution);
        if ($printResponse[0] != 0) {
                $dataExecution{'code'} = 1; # execution error
        } else {
                $dataExecution{'code'} = 2; # correct execution
                $dataExecution{'prints'} = $printResponse[1];
        }
      }
      return \%dataExecution;
}

sub ExistPOLanguage
{
       my $langCode = shift;
       $Bin = $routeLangInstaller; # $Bin happens to have the path to LangInstaller.pm
       my $installer = LangInstaller->new();
       my $activeLanguages = GetActiveLanguages();
       my $dummyLang = $installer->{langs};
       my @allLanguages = @$dummyLang;
       my $ln;
       my $found = 0;
       for $ln (@allLanguages){
               if ($ln =~ /\S+/) {
                       if ($ln eq $langCode) {
                               $found = 1;
                               last;
                       }
               }
       }
       return $found;
}

sub WritePermissionPOsDirectory
{
      my $tableHTML;
      my $routePOsDirectory = $routeLangInstaller . '/po';
      if (!-w $routePOsDirectory) {
              # Return table with directory permissions information
              my $user;
              my $group;
              if ((my $dev,my $ino,my $mode,my $nlink,my $uid,my $gid,my $rdev,my $size,my $atime,my $mtime,my $ctime,my $blksize,my $blocks) = lstat($routePOsDirectory)) {
                      $user = getpwuid($uid);
                      $group = getgrgid($gid);
              }
              $tableHTML .= '<tr><td><b>' . $routePOsDirectory . '</b></td><td>' . $user . '</td><td>' . $group . '</td>';
              $tableHTML .= '<td>' . file_mode($routePOsDirectory) . '</td></tr>';

      } else {
              $tableHTML = '';
      }
      return $tableHTML;
}

sub CreateLanguagePOfiles
{
      my %dataExecution;
      my $langCode = shift;
      # Create new language PO files
      my $execution = "cd $routeLangInstaller;perl ./translate create $langCode";
      my @printResponse = system_capture($execution);
      if ($printResponse[0] != 0) {
              $dataExecution{'code'} = 1; # execution error
      } else {
              $dataExecution{'code'} = 2; # correct execution
              $dataExecution{'prints'} = $printResponse[1];
      }
      return \%dataExecution;
}

sub UpdateTranslationActiveLang
{
      my %dataExecution;
      my $langCode = shift;
      # Install/Update language
      my $execution = "cd $routeLangInstaller;perl ./translate install $langCode";
      my @printResponse = system_capture($execution);
      if ($printResponse[0] != 0) {
              $dataExecution{'code'} = 1; # execution error
      } else {
              $dataExecution{'code'} = 2; # correct execution
              $dataExecution{'prints'} = $printResponse[1];
      }
      return \%dataExecution;
}

sub IsActiveLanguage
{
       my $langCode = shift;
       my $found = 0;
       my $activeLanguages = GetActiveLanguages();
       foreach my $lni (@$activeLanguages){
               if ($langCode eq $lni->{'code'}) {
                       $found = 1;
                       last;
               }
       }
       return $found;
}

sub DeletePOfiles
{
        my $filenames = shift;
        my $error = 0;
        if (ExistPOfile($filenames->{'POfile_pref'}) && PermissionPOfile($filenames->{'POfile_pref'})){
                if (!unlink $filenames->{'POfile_pref'}) { $error = 1; }
        }
        if (ExistPOfile($filenames->{'POfile_opac'}) && PermissionPOfile($filenames->{'POfile_opac'})){
                if (!unlink $filenames->{'POfile_opac'}) { $error = 1; }
                if (ExistPOfile($filenames->{'POfile_opac'} . '~') && PermissionPOfile($filenames->{'POfile_opac'} . '~')){
                        if (!unlink $filenames->{'POfile_opac'} . '~') { $error = 1; }
                }
        }
        if (ExistPOfile($filenames->{'POfile_intranet'}) && PermissionPOfile($filenames->{'POfile_intranet'})){
                if (!unlink $filenames->{'POfile_intranet'}) { $error = 1; }
                if (ExistPOfile($filenames->{'POfile_intranet'} . '~') && PermissionPOfile($filenames->{'POfile_intranet'} . '~')){
                        if (!unlink $filenames->{'POfile_intranet'} . '~') { $error = 1; }
                }
        }
        return $error;
}

my $query = new CGI;
my ($template, $loggedinuser, $cookie) = get_template_and_user({
        template_name => "admin/translations_manager.tt",
        query => $query,
        type => "intranet",
        authnotrequired => 0,
        flagsrequired => {parameters => 1},
        debug => 1,
});

$lang = $template->param( 'lang' );
my $op = $query->param('op') || '';
# Update PO params
$selectedlang = $query->param('selectedlang'); # Use in Delete PO
$selectedPO = $query->param('selectedPO');
$selectedTemplate = $query->param('selectedTemplate');
$selectedSection = $query->param('selectedSection');
# Create Translation from PO params
$selectedInactivelang = $query->param('selectedInactivelang');
# Create PO params
$newLangCode = $query->param('newLangCode');
# Update Translation from PO params
$selectedActivelang = $query->param('selectedActivelang');

my $display = $query->param('display') || '';
if ($display eq '') {
        $display = 'createpo';
}
if ($display eq 'createpo') {
        $template->param(
                createpo => 'createpo',
        );
} else {
        if ($display eq 'editpo') {
                $template->param(
                        editpo => 'editpo',
                );
        } else {
                if ($display eq 'createtranslation') {
                        $template->param(
                                createtranslation => 'createtranslation',
                        );
                } else {
                        if ($display eq 'updatetranslation') {
                                $template->param(
                                        updatetranslation => 'updatetranslation',
                                );
                        } else {
                                if ($display eq 'deletepo') {
                                        $template->param(
                                                deletepo => 'deletepo',
                                        );
                                }
                        }
                }
        }
}

if ($display eq 'editpo') {
       # Obtaining all languages with PO file
       my @langData = GetPOLanguages(0);
       $template->param(
               langData => \@langData,
       );
       if ($op eq 'SELECT_LANGUAGE' || $op eq 'SELECT_PO_FILE' || $op eq 'SELECT_TEMPLATE' || $op eq 'SELECT_SECTION' || $op eq 'UPDATE_LABELS') {
               # Update PO file

               # Determine the names of PO files for the selected language
               my $filenames = GetPOfilenames();
               # Create the options of the PO files combobox
               my @PoFiles = MakeOptionsComboboxPO($filenames);
               # Get table of PO files permissions
               my $tablePermissions = MakePermissionsTable($filenames);
               # Get user and group that is executing the script
               my $scriptUser = getpwuid(getuid());
               (my $scriptUser_name, my $scriptUser_passwd, my $scriptUser_uid, my $scriptUser_gid, my $scriptUser_quota, my $scriptUser_comment, my $scriptUser_gcos, my $scriptUser_dir, my $scriptUser_shell) = getpwnam($scriptUser);
               my $scriptGroup = getgrgid($scriptUser_gid);
               $template->param(
                        selectedlang => $selectedlang,
                        poFiles => \@PoFiles,
                        viewPoSelect => 1,
                        tablePermissions => $tablePermissions,
                        scriptUser => $scriptUser,
                        scriptGroup => $scriptGroup,
               );
               if ($op eq 'SELECT_PO_FILE' || $op eq 'SELECT_TEMPLATE' || $op eq 'SELECT_SECTION' || $op eq 'UPDATE_LABELS') {
                       # Open selected PO file
                       my $POobjects = OpenPOfile();

                       if ($op eq 'UPDATE_LABELS') {
                               # Update PO objects, update PO file
                               UpdatePOLabels($POobjects, $query);
                               $template->param(
                                        savedPo => 1,
                               );
                       }

                       my $templatesData;
                       if ($selectedPO ne $filenames->{'POfile_pref'}){
                               # PO file from opac or staff
                               # Get the templates
                               my $templatesData = GetTemplatesPOfile($POobjects);
                               # Create the options of the templates combobox
                               my @Templates = MakeOptionsComboboxTemplates($templatesData);
                               $template->param(
                                        selectedPO => $selectedPO,
                                        templates => \@Templates,
                                        viewTemplateSelect => 1,
                               );

                               if ($op eq 'SELECT_TEMPLATE' || $op eq 'UPDATE_LABELS') {
                                       # Get labels from a template
                                       my $labelsData = GetLabelsTemplatesPOfile($POobjects, $selectedTemplate);
                                       # Make label form fields
                                       my @LabelsFields = MakeFieldsLabels($labelsData);
                                       $template->param(
                                                selectedTemplate => $selectedTemplate,
                                                labelsFields => \@LabelsFields,
                                                viewLabelsForm => 1,
                                       );

                               }
                       } else {
                               # Preferences PO file
                               # Get comments (preference sections)
                               my $commentsData = GetCommentsPOfile($POobjects);
                               # Create the options of the preference sections combobox
                               my @Sections = MakeOptionsComboboxSections($commentsData);
                               $template->param(
                                        selectedPO => $selectedPO,
                                        sections => \@Sections,
                                        viewSectionSelect => 1,
                               );

                               if ($op eq 'SELECT_SECTION' || $op eq 'UPDATE_LABELS') {
                                       # Get labels from a preference section
                                       my $labelsData = GetLabelsSectionsPOfile($POobjects, $selectedSection);
                                       # Make label form fields
                                       my @LabelsFields = MakeFieldsLabels($labelsData);
                                       $template->param(
                                                selectedSection => $selectedSection,
                                                labelsFields => \@LabelsFields,
                                                viewLabelsForm => 1,
                                       );
                               }

                       }
               }
        }
} else {
        if ($display eq 'createtranslation') {
                # Create Translation
                my $scriptUser = getpwuid(getuid());
                (my $scriptUser_name, my $scriptUser_passwd, my $scriptUser_uid, my $scriptUser_gid, my $scriptUser_quota, my $scriptUser_comment, my $scriptUser_gcos, my $scriptUser_dir, my $scriptUser_shell) = getpwnam($scriptUser);
                my $scriptGroup = getgrgid($scriptUser_gid);
                # Get no active languages with PO files
                my @inactiveLangData = GetPOLanguages(1);
                $template->param(
                        inactiveLangData => \@inactiveLangData,
                );
                if ($op eq 'SELECT_INACTIVE_LANGUAGE') {
                        # Test write permissions to make directories
                        my $templateDirsPer = WriteTemplateDirs();
                        if ($templateDirsPer eq '') {
                                # Create translation from non active language
                                $template->param(
                                        selectedInactivelang => $selectedInactivelang,
                                );
                                # my $process = CreateTranslationInactiveLang($selectedInactivelang);
                                # if ($process->{'code'} == 0) {
                                        # # Translation not created (directories found)
                                         # $template->param(
                                                # noCreateTranslationDirFound => 1,
                                         # );
                                # } else {
                                my $process = UpdateTranslationActiveLang($selectedInactivelang);
                                if ($process->{'code'} == 1) {
                                        # Translation not created (execution error)
                                        $template->param(
                                               noCreateTranslationError => 1,
                                        );
                                } else {
                                        if ($process->{'code'} == 2) {
                                                # Translation created
                                                $template->param(
                                                       CreateTranslation => 1,
                                                       CreateTranslationDetails => $process->{'prints'},
                                                );
                                        }
                                }
                                #}
                        } else {
                               # No write permissions in directories
                               # Return this information
                               $template->param(
                                        selectedInactivelang => $selectedInactivelang,
                                        tableTemplateDirs => $templateDirsPer,
                                        scriptUser => $scriptUser,
                                        scriptGroup => $scriptGroup,
                               );
                        }
                }
        } else {
                if ($display eq 'createpo' && $op eq 'INSERT_NEW_LANGUAGE') {
                        # Create PO file
                        $template->param(
                                 newLangCode => $newLangCode,
                        );
                        my $existLangCode = ExistPOLanguage($newLangCode);
                        if ($existLangCode) {
                                # Language code exists in other PO file
                                $template->param(
                                         langCodeExist => 1,
                                );
                        } else {
                                my $POsDirsPer = WritePermissionPOsDirectory();
                                if ($POsDirsPer eq '') {
                                        # Create new language PO files
                                        my $process = CreateLanguagePOfiles($newLangCode);
                                        if ($process->{'code'} == 1) {
                                                # PO files not created (execution error)
                                                $template->param(
                                                       noCreatePOError => 1,
                                                );
                                        } else {
                                                if ($process->{'code'} == 2) {
                                                        # PO files created
                                                        $template->param(
                                                               CreatePo => 1,
                                                               CreatePoDetails => $process->{'prints'},
                                                        );
                                                }
                                        }
                                } else {
                                       # No write permissions at PO directory
                                       # Return this information
                                       my $scriptUser = getpwuid(getuid());
                                       (my $scriptUser_name, my $scriptUser_passwd, my $scriptUser_uid, my $scriptUser_gid, my $scriptUser_quota, my $scriptUser_comment, my $scriptUser_gcos, my $scriptUser_dir, my $scriptUser_shell) = getpwnam($scriptUser);
                                       my $scriptGroup = getgrgid($scriptUser_gid);
                                       $template->param(
                                                tablePODir => $POsDirsPer,
                                                scriptUser => $scriptUser,
                                                scriptGroup => $scriptGroup,
                                       );
                                }
                        }
                } else {
                        if ($display eq 'updatetranslation') {
                                # Update Translation
                                my $scriptUser = getpwuid(getuid());
                                (my $scriptUser_name, my $scriptUser_passwd, my $scriptUser_uid, my $scriptUser_gid, my $scriptUser_quota, my $scriptUser_comment, my $scriptUser_gcos, my $scriptUser_dir, my $scriptUser_shell) = getpwnam($scriptUser);
                                my $scriptGroup = getgrgid($scriptUser_gid);
                                # Get active languages with PO files
                                my @activeLangData = GetPOLanguages(2);
                                $template->param(
                                        activeLangData => \@activeLangData,
                                );
                                if ($op eq 'SELECT_ACTIVE_LANGUAGE') {
                                        my $templateDirsPer = WriteTemplateDirs();
                                        if ($templateDirsPer eq '') {
                                                # Update an active language translation
                                                $template->param(
                                                        selectedActivelang => $selectedActivelang,
                                                );
                                                my $process = UpdateTranslationActiveLang($selectedActivelang);
                                                if ($process->{'code'} == 1) {
                                                        # Translation not updated (execution error)
                                                        $template->param(
                                                               noUpdateTranslationError => 1,
                                                        );
                                                } else {
                                                        if ($process->{'code'} == 2) {
                                                                # Translation updated
                                                                $template->param(
                                                                       UpdateTranslation => 1,
                                                                       UpdateTranslationDetails => $process->{'prints'},
                                                                );
                                                        }
                                                }
                                        } else {
                                               # No write permissions in the directories
                                               # Return this information
                                               $template->param(
                                                        selectedActivelang => $selectedActivelang,
                                                        tableTemplateDirs2 => $templateDirsPer,
                                                        scriptUser => $scriptUser,
                                                        scriptGroup => $scriptGroup,
                                               );
                                        }
                                }
                        } else {
                                if ($display eq 'deletepo') {
                                        # Delete Language PO files
                                        my $scriptUser = getpwuid(getuid());
                                        (my $scriptUser_name, my $scriptUser_passwd, my $scriptUser_uid, my $scriptUser_gid, my $scriptUser_quota, my $scriptUser_comment, my $scriptUser_gcos, my $scriptUser_dir, my $scriptUser_shell) = getpwnam($scriptUser);
                                        my $scriptGroup = getgrgid($scriptUser_gid);
                                        # Obtaining all languages with PO file
                                        my @langData = GetPOLanguages(0);
                                        if ($op eq 'SELECT_LANGUAGE_DELETE') {
                                                # Determine the names of PO files for the selected language
                                                my $filenames = GetPOfilenames();
                                                if ((ExistPOfile($filenames->{'POfile_pref'}) && !PermissionPOfile($filenames->{'POfile_pref'})) || (ExistPOfile($filenames->{'POfile_opac'}) && !PermissionPOfile($filenames->{'POfile_opac'})) || (ExistPOfile($filenames->{'POfile_intranet'}) && !PermissionPOfile($filenames->{'POfile_intranet'}))){
                                                        # No permissions to delete all language PO files
                                                        # Get table of PO files permissions
                                                        my $tablePermissions = MakePermissionsTable($filenames);
                                                        $template->param(
                                                                deleteLangData => \@langData,
                                                                selectedlang => $selectedlang,
                                                                tablePermissions => $tablePermissions,
                                                                scriptUser => $scriptUser,
                                                                scriptGroup => $scriptGroup,
                                                       );
                                                } else {
                                                        # Permission to delete all language PO files
                                                        my $deletedPOfiles = DeletePOfiles($filenames);
                                                        if ($deletedPOfiles == 0){
                                                                # All files deleted
                                                                my @langDataAfter = GetPOLanguages(0);
                                                                $template->param(
                                                                        deleteLangData => \@langDataAfter,
                                                                        selectedlang => $selectedlang,
                                                                        deletePo => 1,
                                                               );
                                                        } else {
                                                                # Delete error
                                                                $template->param(
                                                                        deleteLangData => \@langData,
                                                                        selectedlang => $selectedlang,
                                                                        noDeletePo => 1,
                                                               );
                                                        }
                                                }
                                        } else {
                                                $template->param(
                                                        deleteLangData => \@langData,
                                                );
                                        }
                                }
                        }
                }
        }
}

output_html_with_http_headers $query, $cookie, $template->output;
