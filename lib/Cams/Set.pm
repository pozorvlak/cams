package Cams::Set;

use strict;
use warnings;

use base qw/Set::Object/;

use namespace::autoclean;
use Scalar::Util qw/blessed/;
use List::Util qw/sum/;

# XXX: Perhaps extend the inherited ->new method to validate that all
# members are the right shape (name, min, max, weight, cost)

sub set {
    my $class = __PACKAGE__;
    $class = blessed(shift)
        if blessed($_[0]) && $_[0]->isa('Set::Object');
    $class->new(@_);
}

sub covering {
    my ($self, $width) = @_;
    my $class = ref $self;
    return [map { $class->new($_) }
            grep { $_->{min} <= $width && $_->{max} >= $width }
            $self->members()];
}

sub weight {
    my ($self) = @_;
    return sum(map { $_->{'weight'} } $self->members());
}

sub as_string {
    my ($self, $cost_method) = @_;
    my $s = join(", ", map { $_->{'name'} } $self->members());
    $s .= ": " . $self->$cost_method() if defined($cost_method);
    return $s;
}

1;
