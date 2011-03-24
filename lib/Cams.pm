#!/usr/bin/perl

package Cams;

use warnings;
use strict;
use 5.010;

use Cams::Solver;
use Cams::Data qw/test_data/;

sub solve {
    (my $min, my $max) = @_;
    my $data = test_data();
    my $solver = Cams::Solver->new($data, $min, $max, 'mass');

    if (!$solver->solutions) {
        return 'No solutions are possible';
    }
    else {
        return $solver->solutions_as_string;
    }
}

1;
