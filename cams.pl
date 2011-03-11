#!/usr/bin/perl

package Cams;

use warnings;
use strict;
use 5.010;
use Algorithm::Simplex;
use Data::Dumper;

my $min = 15;
my $max = 49;

# Made up data
my @cams = (
# Wild Diamond, a Johannesburg firm
    { name => "WD Friend 4", min => 5, max => 17, weight => 7 },
    { name => "WD Friend 5", min => 15, max => 25, weight => 9 },
    { name => "WD Friend 6", min => 23, max => 37, weight => 13 },
    { name => "WD Friend 7", min => 35, max => 52, weight => 20 },
    { name => "WD Friend 8", min => 50, max => 70, weight => 37 },
# Black Country, the well-known Lancashire cam manufacturer
    { name => "BC Camalot 1", min => 10, max => 19, weight => 8 },
    { name => "BC Camalot 2", min => 17, max => 27, weight => 10 },
    { name => "BC Camalot 3", min => 25, max => 36, weight => 12 },
    { name => "BC Camalot 4", min => 33, max => 44, weight => 17 },
    { name => "BC Camalot 5", min => 42, max => 55, weight => 23 },
    { name => "BC Camalot 6", min => 54, max => 70, weight => 34 },
);

# Build a Tucker tableau
my @matrix = ();
foreach my $width ($min .. $max) { # off-by-one?
    push @matrix,
        [ map { $_->{min} <= $width && $_->{max} > $width ? 1 : 0 } @cams];
}

print Dumper @matrix;

1;
