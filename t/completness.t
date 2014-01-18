#!/usr/bin/perl
use warnings;
use strict;

use FindBin qw($Bin);
use Test::More;
use Syntax::Construct ();


unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => "Author tests not required for installation" );
}

my %constructs;

my $libfile = $INC{'Syntax/Construct.pm'};
open my $IN, '<', $libfile or die $!;
my $version;
while (<$IN>) {
    if (my ($v) = /^=head2 ([.0-9]+)/) {
        $version = $v;
    }

    if (my ($constr) = /^=head3 (.*)/) {
        $constructs{$constr}{pod}++;
        $constructs{$constr}{version}{$version}++;

    } elsif (($constr, my $v) = /^ +'(.+)' +=> ([.0-9]+),$/) {
        $constructs{$constr}{code}++;
        $constructs{$constr}{version}{$v}++;
    }
}

open my $TEST, '<', "$Bin/02-constructs.t" or die $!;
undef $version;
while (<$TEST>) {
    if (my ($v) = /^ +'([.0-9]+)' => \[$/) {
        $version = $v;
    }
    if (my ($constr) = /^ +\[ '(.+)',/) {
        $constructs{$constr}{test}++;
        $constructs{$constr}{version}{$version}++;
    }
}

for my $constr (keys %constructs) {
    is_deeply([ @{ $constructs{$constr} }{qw(pod code test)} ],
              [1, 1, 1], "pod, code, test for $constr");

    my @versions = keys %{ $constructs{$constr}{version} };
    is(@versions, 1, "versions $constr");
    is($constructs{$constr}{version}{$versions[0]}, 3, "version $constr");
}

done_testing(3 * keys %constructs);
