package C4::FileLocalRepository;

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
use CGI;
use C4::Context;
use C4::Biblio;
use GD;
use File::Glob;
use File::Basename;
use File::Copy;
use MARC::Record;
use MARC::File::USMARC;
use MARC::File::XML;
use DBI;


use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

my $imgmag;


BEGIN {
    $VERSION = 3.02;    # set version for version checking
    require Exporter;
    @ISA    = qw(Exporter);
    @EXPORT = qw(
      &uploadDocumentLR
      &updateUriItemDBLR
      &uploadFilesLR
      &showCoverImageLR
      &showDocLR
      &deleteFileLR
      &disposeNoisyChars
      &copyDocumentLR
    );
    $imgmag = 1;
    eval {
        require Image::Magick;
    };
    $imgmag = 0 if ($@);
}


$CGI::POST_MAX = 1024 * 1024 * ((C4::Context->preference("MaxSizeFileLocalRepository") && C4::Context->preference("MaxSizeFileLocalRepository") =~ /^[1-9][0-9]*$/)?C4::Context->preference("MaxSizeFileLocalRepository"):10);


sub uploadDocumentLR
{
    my ($input, $id, $record, $frameworkcode, $isItem) = @_;

    my $urldocumentbibliofile;
    my $documentbibliofilename = uploadFilesLR($input, '', 'modify', ['documentbibliofile'], [$id], 0);
    if ($documentbibliofilename) {
        $urldocumentbibliofile = showDocLR($id, $input, undef, C4::Context->preference("dirFileLocalRepository"), C4::Context->preference("dirUrlLocalRepository"));
        if ($urldocumentbibliofile) {
            $urldocumentbibliofile .= $documentbibliofilename;
            unless ($isItem) {
                if (!$record->field('856')) {
                    my $newField = MARC::Field->new("856",'','','u' => $urldocumentbibliofile);
                    $newField->add_subfields('y' => 'Ver documento');
                    $record->insert_fields_ordered($newField);
                } elsif (!$record->field('856')->subfield('u')) {
                    $record->field('856')->add_subfields('u' => $urldocumentbibliofile);
                    $record->field('856')->add_subfields('y' => 'Ver documento');
                } else {
                    $record->field('856')->update('u' => $urldocumentbibliofile);
                    $record->field('856')->update('y' => 'Ver documento');
                }
                ModBiblio( $record, $id, $frameworkcode );
            } else {
                my ($biblionumber, $itemnumber) = split('_', $id);
                updateUriItemDBLR($itemnumber, $urldocumentbibliofile);
                ModZebra( $biblionumber, "specialUpdate", "biblioserver", undef, undef );
                # my $biblio_marc = GetMarcBiblio($biblionumber);
                # foreach my $field ($biblio_marc->field('952')) {
                    # if ($field->subfield('9') == $itemnumber) {
                        # if (!$field->subfield('u')) {
                            # $field->add_subfields('u' => $urldocumentbibliofile);
                        # } else {
                            # $field->update('u' => $urldocumentbibliofile);
                        # }
                        # updateUriItemDBLR($itemnumber, $urldocumentbibliofile);
                        # ModBiblioMarc($biblio_marc, $biblionumber, $frameworkcode);
                        # last;
                    # }
                # }
            }
        }
    }
    return $urldocumentbibliofile;
}#uploadDocumentLR


sub updateUriItemDBLR
{
    my ($itemnumber, $uri, $record, $biblionumber) = @_;

    my $dbh = C4::Context->dbh;
    eval {
        my $sth = $dbh->prepare("UPDATE items SET uri=? WHERE itemnumber=?");
        $sth->execute( $uri, $itemnumber );
        $sth->finish;
        if ($record && $biblionumber) {
            $sth = $dbh->prepare("UPDATE biblioitems SET marc=?,marcxml=? WHERE biblionumber=?");
            $sth->execute( $record->as_usmarc(), $record->as_xml_record(C4::Context->preference("marcflavour")), $biblionumber );
            $sth->finish;
        }
    };
}#updateUriItemDBLR


sub uploadFilesLR
{
    my ($query, $uploadDir, $op, $fieldsForm, $fileNames, $parseBool, $Width, $Height, $noThumbBool, $WidthMin, $HeightMin) = @_;

    $uploadDir = C4::Context->preference("dirFileLocalRepository") unless ($uploadDir);
    return unless (-d $uploadDir);
    $uploadDir .= '/' unless ($uploadDir =~ /\/$/);
    my ($fileName, $uploadDirFin);
    if ($op ne 'delete') {
        for (my $i=0; $i < @$fieldsForm; $i++) {
            $fileName = $query->param($fieldsForm->[$i]);
            if ($fileName) {
                if (exists($fileNames->[$i]) && defined($fileNames->[$i])) {
                    unless ($fileNames->[$i] =~ /\.[a-zA-Z0-9]{2,4}$/) {
                        if ($fileName =~ /(\.[a-zA-Z0-9]{2,4})$/) {
                            $fileNames->[$i] .= lc($1);
                        } else {
                            return;
                        }
                    }
                    if ($parseBool) {
                        $fileName = disposeNoisyChars($fileNames->[$i]);
                    } else {
                        $fileName = $fileNames->[$i];
                    }
                } else {
                    $fileName = _parseFileName($fileName);
                }
                #print $fileName;
                $uploadDirFin = $uploadDir;
                $uploadDirFin .= ($fileName =~ /^.+\.(gif|jpg|jpeg|png)$/i)?'covers/':'documents/';
                mkdir $uploadDirFin unless (-d $uploadDirFin);
                #print $uploadDirFin;
                if ($op eq 'modify') {
                    my $fileNameNoExt = $fileName;
                    $fileNameNoExt =~ s/\.[a-zA-Z0-9]{2,4}$//;
                    deleteFileLR($uploadDirFin, $fileNameNoExt);
                    deleteFileLR($uploadDirFin, 'Thumb_' . $fileNameNoExt) if ($fileName =~ /^.+\.(gif|jpg|jpeg|png)$/i);
                }
                my $uploadFd = $query->upload($fieldsForm->[$i]);
                if ($uploadFd && !$query->cgi_error) {
                    my $tmpfilename = $query->tmpFileName($query->param($fieldsForm->[$i]));
                    _copyFile($uploadDirFin, $fileName, [$uploadFd, $tmpfilename], $Width, $Height, $noThumbBool, $WidthMin, $HeightMin);
                } else {
                    $fileName = undef;
                }
            }
        }#for
    } else {
        for $fileName (@$fileNames) {
            $uploadDirFin = ($fileName =~ /^.+\.(gif|jpg|jpeg|png)$/i)?'covers/':'documents/';
            mkdir $uploadDirFin unless (-d $uploadDirFin);
            deleteFileLR($uploadDirFin, $fileName);
        }
    }
    return $fileName;
}#uploadFilesLR


sub _copyFile
{
    my ($uploadDir, $fileName, $uploadFdArr, $Width, $Height, $noThumbBool, $WidthMin, $HeightMin) = @_;

    my ($uploadFd, $tmpFileName) = @$uploadFdArr;
    if ($fileName =~ /^.+\.(gif|jpg|jpeg|png)$/i) {
        my ($myImage, $idealImH, $idealImW, $idealImMinH, $idealImMinW, $imageMin, $imageMin2, $ext);
        $ext = lc($1);
        $idealImH = ($Height)?$Height:600;
        $idealImW = ($Width)?$Width:420;
        $idealImMinH = ($HeightMin)?$HeightMin:124;
        $idealImMinW = ($WidthMin)?$WidthMin:90;

        if ($imgmag) {
            eval {
                $myImage = new Image::Magick;
                $myImage->Read($tmpFileName);
            };
        } else {
            eval {
                SWITCH: for ($ext) {
                    /^gif$/ && do {
                        $myImage = newFromGif GD::Image($uploadFd) || die "$!";
                        last SWITCH;
                    };
                    /^jpe?g$/ && do {
                        $myImage = newFromJpeg GD::Image($uploadFd);
                        last SWITCH;
                    };
                    /^png$/ && do {
                        $myImage = newFromPng GD::Image($uploadFd) || die "$!";
                        last SWITCH;
                    };
                }
            };
        }
        if ($myImage) {
            $fileName =~ s/\.(gif|jpg|jpeg|png)$/\.$ext/i;
            if ($imageMin = _ImgMin($myImage, $idealImW, $idealImH, $uploadDir . $fileName)) {
                _writeImg2File($imageMin, $uploadDir, $fileName, $ext) unless ($imgmag);
            }
            if (!$noThumbBool && ($imageMin2 = _ImgMin($myImage, $idealImMinW, $idealImMinH, $uploadDir . 'Thumb_' . $fileName))) {
                _writeImg2File($imageMin2, $uploadDir, 'Thumb_' . $fileName, $ext) unless ($imgmag);
            }
        }

        undef($imageMin);
        undef($imageMin2);
        undef($myImage);
    } else {
        if (open ( UPLOADFILE, ">$uploadDir/$fileName" )) {
            binmode UPLOADFILE;
            while ( <$uploadFd> ) {
                print UPLOADFILE;
            }
            close UPLOADFILE;
        }
    }
}#_copyFile


sub _writeImg2File
{
    my ($img, $uploadDir, $fileName, $ext) = @_;


    if (open ( UPLOADFILE, ">$uploadDir/$fileName" )) {;
        binmode UPLOADFILE;
        SWITCH: for ($ext) {
            /^gif$/ && do {
                print UPLOADFILE $img->gif();
                last SWITCH;
            };
            /^jpe?g$/ && do {
                print UPLOADFILE $img->jpeg();
                last SWITCH;
            };
            /^png$/ && do {
                print UPLOADFILE $img->png();
                last SWITCH;
            };
        }
        close UPLOADFILE;
    }
}#_writeImg2File


sub _ImgMin
{
    my ($myImage, $idealImW, $idealImH, $fileResized) = @_;

    my ($tamW, $tamH, $width, $height);

    if ($imgmag) {
        $width = $myImage->Get('base-columns');
        $height = $myImage->Get('base-rows');
    } else {
        ($width, $height) = $myImage->getBounds();
    }
    return undef unless ($height);
    my ($realDiv) = $width / $height;

    $tamW = $idealImW;
    $tamH = $idealImH;
    if ($width > $idealImW || $height > $idealImH) {
        if($realDiv > 1 ) {
            $tamH = int (($tamW  * $height) / $width);
        } else {
            $tamW = int (($tamH * $width) / $height);
        }
        my $imageMin;
        if ($imgmag) {
            $myImage->Resize(width=>$tamW, height=>$tamH, blur=>1);
            return $myImage->Write($fileResized);
        } else {
            eval {
                $imageMin = GD::Image->newTrueColor($tamW, $tamH);
                $imageMin->copyResampled($myImage, 0, 0, 0, 0, , $tamW, $tamH, $width, $height);
            };
            if ($@) {
                $imageMin = GD::Image->new($tamW, $tamH);
                $imageMin->copyResized($myImage, 0, 0, 0, 0, , $tamW, $tamH, $width, $height);
            }
        }
        return $imageMin;
    } else {
        if ($imgmag) {
            $myImage->Write($fileResized);
            return $myImage;
        } else {
            my $imageMin;
            eval {
                $imageMin = GD::Image->newTrueColor($tamW, $tamH);
                $imageMin->copyResampled($myImage, 0, 0, 0, 0, , $tamW, $tamH, $width, $height);
            };
            if ($@) {
                $imageMin = GD::Image->new($tamW, $tamH);
                $imageMin->copyResized($myImage, 0, 0, 0, 0, , $tamW, $tamH, $width, $height);
            }
            return $imageMin;
        }
    }
    return undef;
}#_ImgMin




sub _parseFileName
{
    my ($fileName) = @_;

    my ( $name, $path, $extension ) = fileparse ( $fileName, '\..*' );
    $fileName = $name . $extension;
    return disposeNoisyChars($fileName);
}#_parseFileName


sub disposeNoisyChars
{
    my ($fileName) = @_;

    my $safe_filename_characters = "a-zA-Z0-9_\.-";
    $fileName =~ tr/ /_/;
    $fileName =~ s/[^$safe_filename_characters]//g;
    return $fileName;
}#disposeNoisyChars




sub copyDocumentLR
{
    my ($id, $idnew, $urldocumentbibliofile, $frameworkcode, $modifyBiblio) = @_;

    my $dirFLR = C4::Context->preference("dirFileLocalRepository");
    $dirFLR .= '/' unless ($dirFLR =~ /\/$/);
    $dirFLR .= 'documents/';
    my @files = glob($dirFLR . $id . '*');
    if (@files) {
        my ($file, $newfile);
        for $file (@files) {
            next unless ($file =~ /$id\.([a-z0-9]{2,4})$/i);
            $newfile = $dirFLR . $idnew . '.' . $1;
            eval {
                copy($file, $newfile);
            };
        }
    }
    if ($urldocumentbibliofile) {
        $urldocumentbibliofile =~ s/$id\./$idnew./;
        if ($idnew =~ /^([0-9]+)_([0-9]+)$/) {
            my $biblionumber = $1;
            my $itemnumber = $2;
            updateUriItemDBLR($itemnumber, $urldocumentbibliofile);
            ModZebra( $biblionumber, "specialUpdate", "biblioserver", undef, undef );
            # my $biblio_marc = GetMarcBiblio($biblionumber);
            # foreach my $field ($biblio_marc->field('952')) {
                # if ($field->subfield('9') == $itemnumber) {
                    # if (!$field->subfield('u')) {
                        # $field->add_subfields('u' => $urldocumentbibliofile);
                    # } else {
                        # $field->update('u' => $urldocumentbibliofile);
                    # }
                    # if ($modifyBiblio) {
                        # updateUriItemDBLR($itemnumber, $urldocumentbibliofile);
                        # ModBiblioMarc($biblio_marc, $biblionumber, $frameworkcode);
                    # } else {
                        # updateUriItemDBLR($itemnumber, $urldocumentbibliofile, $biblio_marc, $biblionumber);
                    # }
                    # last;
                # }
            # }
        }
    }
}#copyDocumentLR


sub showCoverImageLR
{
    my ($biblionumber, $input, $template, $dir, $url) = @_;

    my $existingcoverimage = 0;
    if ($dir && -d $dir) {
        $dir .= '/' unless ($dir =~ /\/$/);
        $dir .= 'covers/';
        $url .= '/' unless ($url =~ /\/$/);
        $url .= 'covers/';
        my @files = glob($dir . $biblionumber . '*');
        if (@files) {
            for (@files) {
                next unless ($_ =~ /\/$biblionumber\.(gif|jpg|jpeg|png)$/i);
                my $ext = $1;
                my $coverImage = $dir . $biblionumber . '.' . $ext;
                my $coverImageMin = $dir . '/Thumb_' . $biblionumber . '.' . $ext;
                if (-f $coverImage || -f $coverImageMin) {
                    $existingcoverimage = 1;
                    $template->param(urlcoverimage => (-f $coverImage)?$url . $biblionumber . '.' . $ext:'', urlcoverimagemin => (-f $coverImageMin)?$url . 'Thumb_' . $biblionumber . '.' . $ext:'');
                    last;
                }
            }
        }
    }
    $template->param(existingcoverimage => $existingcoverimage);
}#showCoverImageLR


sub showDocLR
{
    my ($biblionumber, $input, $template, $dir, $url) = @_;

    my $existingdocument = 0;
    if ($dir && -d $dir) {
        $dir .= '/' unless ($dir =~ /\/$/);
        $dir .= 'documents/';
        $url .= '/' unless ($url =~ /\/$/);
        $url .= 'documents/';
        my @files = glob($dir . $biblionumber . '*');
        if (@files) {
            for (@files) {
                next unless ($_ =~ /\/$biblionumber\.[a-z0-9]{2,4}$/i);
                $_ =~ s/^.+\///;
                $template->param(urldocument => $url . $_) if ($template);
                $existingdocument = 1;
                last;
            }
        }
    }
    $template->param(existingdocument => $existingdocument) if ($template);
    return $url;
}#showDocLR




sub deleteFileLR
{
    my ($dir, $fileName, $item) = @_;

    if (-d $dir) {
        my @files = glob($dir . $fileName . '*');
        if (@files > 0) {
            my $name;
            for (@files) {
                $name = $_;
                $name =~ s/^.+\///;
                #if ($name =~ /^$fileName(?:_[0-9]*)?\.[a-z0-9]{2,4}$/i && -w $_) {
                if ($name =~ /^$fileName\.[a-z0-9]{2,4}$/i && -w $_) {
                    unlink($_);
                }
            }
        }
    }
}#deleteFileLR


1;
__END__

=head1 AUTHOR

Koha Development Team <http://koha-community.org/>

=cut

