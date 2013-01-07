package cams;
use Dancer ':syntax';
use Cams::Data 'test_data';
use Cams;

our $VERSION = '0.1';

get '/solve' => sub {
    (my $min, my $max) = (params->{min}, params->{max});
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

true;
