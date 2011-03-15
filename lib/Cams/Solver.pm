package Cams::Solver;
use Moose;

has cams        => (is => 'ro', required => 1, isa => 'Cams::Set');
has min         => (is => 'ro', required => 1, isa => 'Num');
has max         => (is => 'ro', required => 1, isa => 'Num');
has cost_method => (is => 'ro', required => 1, isa => 'Str|CodeRef');
has _solutions  => (is => 'ro', init_arg => undef, lazy => 1, builder => 'solve');

use namespace::autoclean;
use Carp qw/croak/;
use POSIX qw/floor/;

sub BUILDARGS {
    my ($class, $cams, $min, $max, $cost_method) = @_;
    no warnings qw<uninitialized numeric>;
    croak "Impossible to solve because min=$min > max=$max"
        if $min > $max;
    return {
        cams        => $cams,
        min         => $min,
        max         => $max,
        cost_method => $cost_method,
    };
}

sub solutions_as_string {
    my ($self) = @_;
    return join '', map { "$_\n" }
        map { $_->as_string($self->cost_method) } $self->solutions;
}

sub solve {
    my ($self) = @_;
    return [ $self->candidates($self->min, $self->max) ];
}

sub best_solution {
    my ($self) = @_;
    return $self->_solutions->[0];
}

sub solutions {
    my ($self) = @_;
    return @{ $self->_solutions };
}

# Return a list of minimal elements of @_; ie x is in the returned list
# iff there is no y in @_ with y < @_.
# Assumes list is sorted.
sub strip_supersets {
    my $self = shift;
    my @seen;
    SET: foreach my $set (@_) {
        foreach my $seen (@seen) {
            next SET if $seen < $set;
        }
        push @seen, $set;
    }
    return @seen;
}

# Given a list of coverings for L and a list of coverings for R, return a list
# of coverings for L+R, sorted by cost (lowest first).
sub merge {
    my ($self, $left, $right) = @_;
    my @answer;
    for my $left_set (@$left) {
        for my $right_set (@$right) {
            push @answer, $left_set + $right_set;
        }
    }
    my $cost_method = $self->cost_method;
    @answer = sort { $a->$cost_method <=> $b->$cost_method } @answer;
    # Comment out next line for EPIC SLOWDOWN :-)
    @answer = $self->strip_supersets(@answer);
    return @answer;
}

sub candidates {
    my ($self, $min, $max) = @_;
    if ($max - $min <= 1) {
        my $cams = $self->cams;
        return $self->merge($cams->covering($min), $cams->covering($max));
    }
    else {
        my $middle = floor(($max + $min)/2);
        return $self->merge([ $self->candidates($min, $middle) ],
                            [ $self->candidates($middle, $max) ]);
    }
}

1;
