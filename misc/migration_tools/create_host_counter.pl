#!/usr/bin/perl

use strict;
#use warnings; FIXME - Bug 2505
BEGIN {
    # find Koha's Perl modules
    # test carefully before changing this
    use FindBin;
    eval { require "$FindBin::Bin/../kohalib.pl" };
}

use C4::Context;
use C4::Biblio;
use C4::Items;
use C4::Search;
use Getopt::Long;

$| = 1;

# command-line parameters
my $want_help = 0;
my $do_update = 0;
my $wherestrings;

my $result = GetOptions(
    'update'    => \$do_update,
    'where=s@'         => \$wherestrings,
    'h|help'        => \$want_help,
);

if (not $result or $want_help or not $do_update) {
    print_usage();
    exit 0;
}

my $num_bibs_processed     = 0;
my $num_bibs_modified      = 0;
my $num_bad_bibs           = 0;
my $num_bibs_processed_del = 0;
my $num_hosts_deleted      = 0;
my $num_bad_bibs_del       = 0;
my $dbh = C4::Context->dbh;
$dbh->{AutoCommit} = 0;

del_host_fields();
process_bibs();
$dbh->commit();

exit 0;

sub process_bibs {
    my $sql = "SELECT biblionumber FROM biblio JOIN biblioitems USING (biblionumber)";
    $sql.="WHERE ". join(" AND ",@$wherestrings) if ($wherestrings);
    $sql.="ORDER BY biblionumber ASC";
    my $sth = $dbh->prepare($sql);
    eval{$sth->execute();};
    if ($@){ die "error $@";};
    while (my ($biblionumber) = $sth->fetchrow_array()) {
        $num_bibs_processed++;
        process_bib($biblionumber);

        if (($num_bibs_processed % 100) == 0) {
            print_progress_and_commit($num_bibs_processed);
        }
    }

    $dbh->commit;

    print <<_SUMMARY_;

Create Host counter report
-----------------------------------------------
Number of bibs checked:                   $num_bibs_processed
Number of host added:                     $num_bibs_modified
Number of bibs with errors:               $num_bad_bibs
_SUMMARY_
}

sub process_bib {
    my $biblionumber = shift;

    my $bib = GetMarcBiblio($biblionumber);
    unless (defined $bib) {
        print "\nCould not retrieve bib $biblionumber from the database - record is corrupt.\n";
        $num_bad_bibs++;
        return;
    }
    my $analyticfield = '773';
    my $hostfield = '973';
    foreach my $host ( $bib->field($analyticfield) ) {
        if(my $control_number = $host->subfield('w')){
            $control_number =~ s/^\(.+\)//;
            my ($error, $results, $total_hits) = C4::Search::SimpleSearch("Control-number:".$control_number);
            foreach my $marc (@$results) {
                $num_bibs_modified++;
                my $record = MARC::Record->new_from_usmarc($marc);
                unless($record->subfield($hostfield, 'w')){
                    $record->insert_fields_ordered(MARC::Field->new($hostfield, '', '', 'w' => '1'));
                }else{
                    $record->field($hostfield)->update('w' => $record->subfield($hostfield, 'w')+1);
                }
                UpdateBiblio($record);
            }
        }
    }
}

sub print_progress_and_commit {
    my $recs = shift;
    $dbh->commit();
    print "... processed $recs records\n";
}

sub print_usage {
    print <<_USAGE_;
$0: establish relationship to host bibs

Parameters:
    -update            run the synchronization
    -where condition       selects the biblios on a criterium (Repeatable)
    --help or -h            show this message.
_USAGE_
}

sub del_host_fields {
    my $sql = "SELECT biblionumber FROM biblio JOIN biblioitems USING (biblionumber)";
    my $sth = $dbh->prepare($sql);
    eval{$sth->execute();};
    if ($@){ die "error $@";};
    while (my ($biblionumber) = $sth->fetchrow_array()) {
        $num_bibs_processed_del++;
        del_host($biblionumber);

        if (($num_bibs_processed_del % 100) == 0) {
            print_progress_and_commit($num_bibs_processed_del);
        }
    }

    $dbh->commit;

    print <<_SUMMARY_;

Delete Host counter report
-----------------------------------------------
Number of bibs checked:                   $num_bibs_processed_del
Number of bibs with host deleted:         $num_hosts_deleted
Number of bibs with errors:               $num_bad_bibs_del
_SUMMARY_
}

sub del_host {
    my $biblionumber = shift;

    my $bib = GetMarcBiblio($biblionumber);
    unless (defined $bib) {
        print "\nCould not retrieve bib $biblionumber from the database - record is corrupt.\n";
        $num_bad_bibs_del++;
        return;
    }
    my $hostfield = '973';
    if ($bib->field($hostfield) ) {
        $num_hosts_deleted++;
        $bib->delete_field($bib->field($hostfield));
        UpdateBiblio($bib);
    }
}
