#!/usr/bin/perl
use warnings;
use strict;

use Test::More tests => 2;
use Syntax::Construct ();

SKIP: {
    eval { 'Syntax::Construct'->import('??'); 1 } or skip $@, 1;

    my $result = eval q{'abc' =~ ?b?};
    is($result, 1, '??');
}

SKIP: {
    eval { 'Syntax::Construct'->import('for-qw'); 1 } or skip $@, 1;

    my $s = 0;
    eval q{ for my $i qw( 1 2 3 ) { $s += $i } };
    is($s, 6, 'for-qw');
}
