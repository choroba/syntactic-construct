#!/usr/bin/perl
use warnings;
use strict;

use Test::More tests => 1;
use Syntax::Construct ();

SKIP: {
    eval { 'Syntax::Construct'->import('??'); 1 } or skip $@, 1;

    my $result = eval q{'abc' =~ ?b?};
    is($result, 1, '??');
}

done_testing();
