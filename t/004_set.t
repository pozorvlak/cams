use v5.10;
use strict;
use warnings;

use Path::Class qw<file>;
use lib file(__FILE__)->dir->parent->subdir('lib')->stringify;

use Test::More tests => 2;
use Cams::Data qw/test_data/;

my $set = test_data();

is $set->min_width, 5, "Minimum width is 5";
is $set->max_width, 70, "Maximum width is 70";
