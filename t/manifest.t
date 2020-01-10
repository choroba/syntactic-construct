#!/usr/bin/perl
use warnings;
use strict;

use Test::More;

unless ($ENV{RELEASE_TESTING}) {
    plan(skip_all => 'Author tests not required for installation');
}

unless (require ExtUtils::Manifest) {
    plan(skip_all => 'ExtUtils::Manifest needed to check manifest');
}

plan(tests => 2);

is_deeply [ ExtUtils::Manifest::manicheck() ], [], 'no missing';
is_deeply [ ExtUtils::Manifest::filecheck() ], [], 'no extra';
