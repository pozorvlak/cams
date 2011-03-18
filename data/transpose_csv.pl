#!/usr/bin/perl -w

use 5.010;
use strict;
use warnings;
use Text::CSV;

my @columns;

my $csv = Text::CSV->new ( { binary => 1 } )
    or die "Cannot use CSV: ".Text::CSV->error_diag();

open my $fh, "<", $ARGV[0] or die "$ARGV[0]: $!";

while (my $row = $csv->getline($fh)) {
    my $i = 0;
    foreach (@$row) {
        push @{ $columns[$i++] }, $_;
    }
}
close $fh;

open my $outfh, ">", $ARGV[1] or die "$ARGV[1]: $!";
foreach my $col (@columns) {
    $csv->print ($outfh, $col);
    print $outfh "\n";
}
