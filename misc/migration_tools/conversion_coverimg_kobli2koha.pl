#!/usr/bin/perl

use strict;
use warnings;

use C4::Context;
use C4::Images;

use GD;
use Getopt::Long;

my $verbose;
my $help;
my $delete;

my $result = GetOptions(
    'v|verbose' => \$verbose,
    'd|delete' => \$delete,
    'h|help' => \$help,
);

if ($help) {
    print <<_USAGE_;
    $0: conversión de portadas de biblios de Kobli a Koha

    Script para guardar las imágenes de las portadas de los biblio
    desde el método de almacenamiento de Kobli (en un directorio) al método
    de Koha (en bbdd).
    La preferencia del sistema "dirFileLocalRepository" indica de dónde se
    han de buscar y leer los ficheros de imágenes.
    
    Parámetros:
    --verbose or -v         mostrar mensajes a medida que realiza acciones.
    --delete or -d          borrar la imagen del directorio del repositorio local.
    --help or -h            mostrar este mensaje.

_USAGE_
    exit(0);
}

my $dir = C4::Context->preference("dirFileLocalRepository");

if ($dir && -d $dir) {
    $dir .= '/' unless ($dir =~ /\/$/);
    $dir .= 'covers';
    if (opendir(my $dh, $dir)) {
        print "Buscando imágenes en $dir\n" if ($verbose);
        my $total = 0;
        my ($file, $biblionumber);
        while (my $f = readdir $dh) {
            $file = "$dir/$f";
            next unless ($f =~ /^([0-9])+\.(?:gif|jpg|jpeg|png)/i);
            $biblionumber = $1;
            my $srcimage = GD::Image->new("$file");
            if ( defined $srcimage ) {
                my $dberror = PutImage($1 , $srcimage, 1 );
                if ($dberror) {
                    print "Error al añadir la imagen $file\n";
                } else {
                    $total++;
                    print "Imagen $file añadida\n" if ($verbose);
                    if ($delete && -w $file) {
                        my $res = unlink($file);
                        if ($verbose) {
                            if ($res) {
                                print "Imagen $file borrada\n";
                            } else {
                                print "No se pudo borrar la imagen $file\n";
                            }
                        }
                    }
                }
            } else {
                print "No se pudo crear la Imagen $file $@\n" if ($verbose);
            }
            undef $srcimage;
        }
        closedir $dh;
        print "Imágenes cambiadas: $total\n" if ($verbose);
    } else {
        print "No se pudo abrir el directorio $dir\n";
    }
} else {
    print "No hay una preferencia de sistema dirFileLocalRepository definida\n";
}