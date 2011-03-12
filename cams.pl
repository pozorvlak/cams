#!/usr/bin/perl

package Cams;

use warnings;
use strict;
use 5.010;
use Set::Object qw/set/;
use List::Util qw/sum/;
use POSIX qw/floor/;
use Data::Dumper;

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

sub weight_of_set {
    my $covering = shift;
    return sum(map { $_->{'weight'} } $covering->members());
}

sub covering {
    my $width = shift;
    my @suitable = grep { $_->{min} <= $width && $_->{max} >= $width } @cams;
    my @names = map({ $_->{name} } @suitable);
    return map { set($_) } @suitable;
}

# Given a list of coverings for L and a list of coverings for R, return a list
# of coverings for L+R, sorted by cost (lowest first).
sub merge {
    (my $left, my $right, my $cost_fn) = @_;
    my @answer = ();
    for my $left_set (@$left) {
        for my $right_set (@$right) {
            push @answer, $left_set + $right_set;
        }
    }
    @answer = sort { $cost_fn->($a) <=> $cost_fn->($b) } @answer;
    return @answer;
}

sub candidates {
    (my $min, my $max, my $cost_fn) = @_;
    if (($max - $min) == 0) {
        return ();
    } elsif (($max - $min ) == 1) {
        return covering($min);
    } else {
        my $middle = floor(($max + $min)/2);
        my $left = [ candidates($min, $middle, $cost_fn) ];
        my $right = [ candidates($middle, $max, $cost_fn) ];
        my @candidates = merge($left, $right, $cost_fn);
        return @candidates;
    }
}

sub say_covering {
    my $covering = shift;
    my $cost_fn = shift;
    print join(", ", map { $_->{'name'} } $covering->members());
    print ": " . $cost_fn->($covering) if defined($cost_fn);
    say "";
}

for my $covering (candidates($ARGV[0], $ARGV[1], \&weight_of_set)) {
    say_covering($covering, \&weight_of_set);
}

1;
