#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 24;
use Data::Dumper;

BEGIN {
    use_ok('C4::Biblio');
}

my @columns = qw(
    tagfield tagsubfield liblibrarian libopac repeatable mandatory kohafield tab
    authorised_value authtypecode value_builder isurl hidden frameworkcode
    seealso link defaultvalue maxlength
);

# biblio.biblionumber must be mapped so this should return something
my $marc_subfield_structure = GetMarcSubfieldStructureFromKohaField('biblio.biblionumber', '');

ok(defined $marc_subfield_structure, "There is a result");
is(ref $marc_subfield_structure, "HASH", "Result is a hashref");
foreach my $col (@columns) {
    ok(exists $marc_subfield_structure->{$col}, "Hashref contains key '$col'");
}
is($marc_subfield_structure->{kohafield}, 'biblio.biblionumber', "Result is the good result");
like($marc_subfield_structure->{tagfield}, qr/^\d{3}$/, "tagfield is a valid tagfield");

# foo.bar does not exist so this should return undef
$marc_subfield_structure = GetMarcSubfieldStructureFromKohaField('foo.bar', '');
is($marc_subfield_structure, undef, "invalid kohafield returns undef");
