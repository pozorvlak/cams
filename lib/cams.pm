package cams;
use Dancer ':syntax';
use Cams::Data 'test_data';
use Cams;
use POSIX qw/floor ceil/;

our $VERSION = '0.1';

get '/solve' => sub {
    (my $min, my $max) = (floor(params->{min}), ceil(params->{max}));
    my $data = test_data();
    my $solver = Cams::Solver->new($data, $min, $max, 'mass');
    template 'results.tt', {
         min => $min,
         max => $max,
         camsets => [ $solver->solutions ]
    };
};

get '/' => sub {
    template 'index';
};

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

true;
