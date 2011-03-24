package cams;
use Dancer ':syntax';
use Cams;

our $VERSION = '0.1';

get '/:min/:max' => sub {
    return Cams::solve(params->{min}, params->{max});
};

get '/' => sub {
    template 'index';
};

true;
