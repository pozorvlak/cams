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

=head1 COPYRIGHT & LICENSE

Copyright 2011-2013 Miles Gould <miles@assyrian.org.uk>

This program is free software; you can redistribute it and/or
modify it under the terms of either:

=over 4

=item * the GNU General Public License as published by the Free
Software Foundation; either version 1, or (at your option) any
later version, or

=item * the Artistic License version 2.0.

=cut

1;
