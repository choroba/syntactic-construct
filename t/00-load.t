#!/usr/bin/perl -T
use strict;
use warnings FATAL => 'all';
use Test::More tests => 1;

BEGIN {
    ok(my $ok = eval('use Syntax::Construct (); 1;'));
    print "Bail out!\n" unless $ok;
}

diag("Testing Syntax::Construct 0.01, Perl $], $^X");
