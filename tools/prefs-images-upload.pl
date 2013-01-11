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

use warnings;
use strict;

use CGI;
use Image::Magick;
use POSIX qw(ceil);
use autouse 'Data::Dumper' => qw(Dumper);

use C4::Context;
use C4::Auth;
use C4::Output;
use C4::Debug;


my $cgi = CGI->new;
my $dbh=C4::Context->dbh;

my $upload_dir = C4::Context->config('opachtdocs')."/prog/imgs/"; 
my $intra_dir = C4::Context->config('intrahtdocs')."/prog/imgs/"; 

my ($template, $loggedinuser, $cookie) = get_template_and_user({
                    template_name       => "tools/prefs-images-upload.tt",
                    query               => $cgi,
                    type                => "intranet",
                    authnotrequired     => 0,
                    debug               => 0,
                    });

for ($cgi->param()) {
    my $file_name = $cgi->param($_) || '';
    my $upload_file = $cgi->upload($_) || '';
    my $op = $cgi->param('op') || 'none';
    my $source_file = "$file_name"; # otherwise we end up with what amounts to a pointer to a filehandle rather than a user-friendly filename
    my $pref="";
  if ($_ && $_ =~ /uploadfile(?:_[0-9]+)?/) {
    my $image_limit = C4::Context->preference('ImageLimit') || '';
    if ($op eq 'upload') {
      if ($upload_file) {
        my $image = Image::Magick->new;
        eval{$image->Read($cgi->tmpFileName($file_name));};
        if ($@) {
            warn sprintf('An error occurred while creating the image object: %s',$@);
            $template->param(
                IMPORT_SUCCESSFUL => 0,
                SOURCE_FILE => $source_file,
                error => 1,
                error_1 => 1,
            );
        }
        elsif($image->Get('height')<=0 || $image->Get('width')<=0){
            warn sprintf('An error occurred while creating the image object: %s',$@);
            $template->param(
                IMPORT_SUCCESSFUL => 0,
                SOURCE_FILE => $source_file,
                error => 1,
                error_2 => 1,
            );
        }
        else {
            $template->param(
                IMPORT_SUCCESSFUL => 1,
                SOURCE_FILE => $source_file,
            );  
            my $height = 100;
            my $name ="";
            my $width = ($image->Get('width')/$image->Get('height'))*$height;
            if ($_ eq "uploadfile_1"){
              $pref = "'opacsmallimage'";
              $file_name =~ m/(\w+)$/;
              $name = "opacsmallimage.".$1;
              if($image->Get('width')>$width || $image->Get('height')>$height){
                $image->Resize(width=>$width, height=>$height, blur=>1);
              }if($image->Get('width')>300){
                $width = 300;
                $height = ($image->Get('height')/$image->Get('width'))*$width;
                $image->Resize(width=>$width, height=>$height, blur=>1);
              }
            }
            elsif ($_ eq "uploadfile_2"){
              $pref = "'opacsmallimageright'";
              $file_name =~ m/(\w+)$/;
              $name = "opacsmallimageright.".$1;
              if($image->Get('width')>$width || $image->Get('height')>$height){
                $image->Resize(width=>$width, height=>$height, blur=>1);
              }if($image->Get('width')>445){
                $width = 445;
                $height = ($image->Get('height')/$image->Get('width'))*$width;
                $image->Resize(width=>$width, height=>$height, blur=>1);
              }
            }
            elsif ($_ eq "uploadfile_3"){
              $pref = "'OpacFavicon'";
              $file_name =~ m/(\w+)$/;
              $name = "OpacFavicon.".$1;
              if($image->Get('width')>25 || $image->Get('height')>25){
                $image->Resize(width=>25, height=>25, blur=>1);
              }
            }
            eval{$image->Write($cgi->tmpFileName($file_name));};
            open (UPLOADFILE, ">$upload_dir/$name") or die "Couldn't open: $!";
            open (UPLOAD, ">$intra_dir/$name") or die "Couldn't open: $!";
            binmode UPLOADFILE;
            binmode UPLOAD;
            while ( <$upload_file> ) {
              print UPLOADFILE;
              print UPLOAD;
            }
            close UPLOADFILE;
            close UPLOAD;
            my $query =  "UPDATE systempreferences 
                          SET value = ? 
                          WHERE variable = ".$pref.";";
            my $sth = $dbh->prepare($query);
            $sth->execute("/opac-tmpl/prog/imgs/".$name);
        }
      }
    }
  }
  elsif ($op eq 'delete') {
    $pref = $cgi->param('pref') || 'none';
    my $query =  "UPDATE systempreferences 
                  SET value = ? 
                  WHERE variable = '".$pref."';";
    my $sth = $dbh->prepare($query);
    $sth->execute("");
    $template->param(
        DELETE_SUCCESSFULL => 1,
    );
  } 
  elsif ($op eq 'none') {
    $template->param(
        IMPORT_SUCCESSFUL => 0,
        SOURCE_FILE => $source_file,
    );
  }
}

my $query =  "SELECT value FROM systempreferences 
              WHERE variable = 'OpacFavicon';";
my $sth = $dbh->prepare($query);
$sth->execute(); 
if(my $data = $sth->fetchrow_hashref->{value}){
    $data =~ s/opac/intranet/;
    $template->param(
        FAVICON => $data,
    );  
}
my $query =  "SELECT value FROM systempreferences 
              WHERE variable = 'opacsmallimage';";
my $sth = $dbh->prepare($query);
$sth->execute(); 
if(my $data = $sth->fetchrow_hashref->{value}){
    $data =~ s/opac/intranet/;
    $template->param(
        SMALLIMAGE => $data,
    );  
}
my $query =  "SELECT value FROM systempreferences 
              WHERE variable = 'opacsmallimageright';";
my $sth = $dbh->prepare($query);
$sth->execute(); 
if(my $data = $sth->fetchrow_hashref->{value}){
    $data =~ s/opac/intranet/;
    $template->param(
        IMAGERIGHT => $data,
    );  
}

output_html_with_http_headers $cgi, $cookie, $template->output;

__END__

=head1 NAME

prefs-images-upload.pl - Script for handling uploading images and importing them into the opac images folder.

=head1 SYNOPSIS

prefs-images-upload.pl

=head1 DESCRIPTION

This script is called and presents the user with an interface allowing him/her to upload images file.

=head1 AUTHOR

Nuño López Ansótegui

=head1 COPYRIGHT

Copyright 2011 Spanish Minister of Culture .

=head1 LICENSE

This file is part of Koha.

Koha is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later version.

You should have received a copy of the GNU General Public License along with Koha; if not, write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA.

=head1 DISCLAIMER OF WARRANTY

Koha is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

=cut
