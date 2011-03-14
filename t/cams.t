#!/usr/bin/perl

use v5.10;
use strict;
use warnings;

use Test::More 0.88;
use Path::Class qw<file>;

my $SCRIPT = file(__FILE__)->dir->parent->file('cams.pl');
my %NAME = (
    wd => 'WD Friend',
    bc => 'BC Camalot',
);

cams_ok('', '', undef);
cams_ok(20, 10, undef);
cams_ok(25, 52, '32 bc3 wd7', '33 wd6 wd7', '52 bc3 bc4 bc5', '53 bc4 bc5 wd6');

done_testing();

sub cams_ok {
    my ($min, $max, @results) = @_;

    if (@results == 1 && !defined $results[0]) {
        my $got = qx[$^X $SCRIPT $min $max 2> /dev/null];
        isnt($?, 0, "`cams.pl $min $max` exits unsuccessfully");
        is($got, '', "... and with no output");
    }
    else {
        my @expected;
        for my $result (@results) {
            my ($total, @cams) = split ' ', $result;
            for (@cams) {
                s/\A ([a-z]+) (?= [0-9]+ \z)/$NAME{$1} /xmsg
                    or die "TEST BUG: unknown cam $_\n";
            }
            push @expected, [$total, sort @cams];
        }

        my $got = qx[$^X $SCRIPT $min $max];
        is($?, 0, "`cams.pl $min $max` exits successfully");
        is_deeply(parse_output($got), \@expected, '... with correct output');
    }
}

sub parse_output {
    my ($got) = @_;
    my @sets;
    for (split /\n/, $got) {
        my ($cams, $cost) = split /: /;
        push @sets, [$cost, sort split /, /, $cams];
    }
    return \@sets;
}
