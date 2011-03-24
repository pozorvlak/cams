#!/usr/bin/perl

use warnings;
use strict;
use 5.010;
use Path::Class qw/file/;
use lib file(__FILE__)->dir->subdir('lib')->absolute->stringify;

use Cams;
use Scalar::Util qw/looks_like_number/;

die "Usage: cams.pl MIN MAX\n"
    if @ARGV != 2 || $ARGV[0] > $ARGV[1]
    || grep { !looks_like_number($_) } @ARGV;

say Cams::solve($ARGV[0], $ARGV[1]);

1;
