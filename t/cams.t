#!/usr/bin/perl

use v5.10;
use strict;
use warnings;

use Path::Class qw<file>;
use lib file(__FILE__)->dir->parent->subdir('lib')->stringify;

use Test::More 0.88;
use Test::Fatal;
use Cams::Solver;
use Cams::Data qw<test_data>;

my $data = test_data();

my %NAME = (
    wd => 'WD Friend',
    bc => 'BC Camalot',
);

like(exception { Cams::Solver->new($data, 20, 10, 'weight') },
     qr/Impossible to solve/, "Can't solve where min > max");

cams_ok(1000, 2000);
cams_ok(25, 52, '32 bc3 wd7', '33 wd6 wd7', '52 bc3 bc4 bc5', '53 bc4 bc5 wd6');
cams_ok(25, 53, '52 bc3 bc4 bc5', '53 bc4 bc5 wd6', '55 bc3 bc5 wd7',
        '56 bc5 wd6 wd7', '69 bc3 wd7 wd8', '70 wd6 wd7 wd8');

done_testing();

sub cams_ok {
    my ($min, $max, @results) = @_;

    my @expected;
    for my $result (@results) {
        my ($total, @cams) = split ' ', $result;
        for (@cams) {
            s/\A ([a-z]+) (?= [0-9]+ \z)/$NAME{$1} /xmsg
                or die "TEST BUG: unknown cam $_\n";
        }
        push @expected, [$total, sort @cams];
    }

    my @got;
    my $solver = Cams::Solver->new($data, $min, $max, 'weight');
    for my $solution ($solver->solutions) {
        push @got, [$solution->weight, sort map { $_->{name} } @$solution];
    }

    is_deeply(\@got, \@expected, "Correct results for min=$min max=$max");
}
