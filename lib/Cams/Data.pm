package Cams::Data;

use strict;
use warnings;

use Exporter qw/import/;
our @EXPORT_OK = qw/test_data/;

use Cams::Set;

# Made up data
my @cams = (
# Wild Diamond, a Johannesburg firm
    { name => "WD Friend 4",  min =>  5, max => 17,  mass =>  7 },
    { name => "WD Friend 5",  min => 15, max => 25,  mass =>  9 },
    { name => "WD Friend 6",  min => 23, max => 37,  mass => 13 },
    { name => "WD Friend 7",  min => 35, max => 52,  mass => 20 },
    { name => "WD Friend 8",  min => 50, max => 70,  mass => 37 },
# Black Country, the well-known Lancashire cam manufacturer
    { name => "BC Camalot 1", min => 10, max => 19, mass =>  8 },
    { name => "BC Camalot 2", min => 17, max => 27, mass => 10 },
    { name => "BC Camalot 3", min => 25, max => 36, mass => 12 },
    { name => "BC Camalot 4", min => 33, max => 44, mass => 17 },
    { name => "BC Camalot 5", min => 42, max => 55, mass => 23 },
    { name => "BC Camalot 6", min => 54, max => 70, mass => 34 },
);

sub test_data {
    return Cams::Set->new(@cams);
}

1;
