#!/usr/bin/perl

use warnings;
use strict;
use 5.010;
use Path::Class qw/file/;
use lib file(__FILE__)->dir->subdir('lib')->absolute->stringify;

use Cams::Solver;
use Cams::Data qw/test_data/;
use Scalar::Util qw/looks_like_number/;

die "Usage: cams.pl MIN MAX\n"
    if @ARGV != 2 || $ARGV[0] > $ARGV[1]
    || grep { !looks_like_number($_) } @ARGV;

my $data = test_data();
my $solver = Cams::Solver->new($data, $ARGV[0], $ARGV[1], 'mass');

if (!$solver->solutions) {
    say 'No solutions are possible';
}
else {
    say $solver->solutions_as_string;
}

1;
