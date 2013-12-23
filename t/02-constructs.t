#!/usr/bin/perl
use warnings;
use strict;

use Test::More;

my %tests = (
    5.018 => [
        [ 'computed labels',
          'my $x = "A"; B:while (1) { A:while (1) { last $x++ }}; 1', 1],
        [ 'our-sub',
          '{our sub xx { 1 } } xx', undef],
        [ 'state-sub',
          '{state sub xx { 1 } } xx', undef],
    ],

    5.014 => [
        [ '?^',
          '"Ab" =~ /(?i)a(?^)b/', 1],
        [ '/r',
          'my $x = "abc"; $x =~ s/c/d/r', 'abd'],
        [ '/a',
          '"\N{U+0e0b}" !~ /^\w$/a', 1]
    ],

    5.012 => [
    ],

    5.010 => [
    ],
);

my $count = 0;
for my $version (keys %tests) {
    my @triples = @{ $tests{$version} };
    if (eval { require ( 0 + $version) }) {
        diag sprintf '%.3f', $version;
        for my $triple (@triples) {
            $count++;
            is(eval $triple->[1], $triple->[2], $triple->[0]);
        }
    }
}

done_testing($count);
__END__



                 '?^'              => v5.14,
                 '/r'              => v5.14,
                 '/d'              => v5.14,
                 '/l'              => v5.14,
                 '/u'              => v5.14,
                 '/a'              => v5.14,
                 'auto-deref'      => v5.14,
                 '^GLOBAL_PHASE'   => v5.14,
                 'IO::File'        => v5.14,
                 'given-return'    => v5.14,

                 'package-version' => v5.12,
                 '...'             => v5.12,
                 'each-array'      => v5.12,
                 'each-keys'       => v5.12,
                 'each-values'     => v5.12,
                 'delete-local'    => v5.12,
                 'length-undef'    => v5.12,

                 '//'              => v5.10,
                 '?PARNO'          => v5.10,
                 '?<>'             => v5.10,
                 'quant+'          => v5.10,
                 'regex-verbs'     => v5.10,
                 '\K'              => v5.10,
                 '\gN'             => v5.10,
                 'readline()'      => v5.10,
                 'stack-file-test' => v5.10,
                 'recursive-sort'  => v5.10,
