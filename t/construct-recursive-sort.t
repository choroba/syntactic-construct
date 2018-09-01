
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Warnings;

expect_known_construct 'recursive-sort';

expect_construct_in_perl
    '5.010' => is_supported,
    '5.012' => is_supported,
    '5.014' => is_supported,
    '5.016' => is_supported,
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => '11122021',
    returns_when_unsupported => '11122021',
    code => <<'EOCODE',
        sub recursive_sort {
            $a->[0] <=> $b->[0]
            or recursive_sort (local $a = [$a->[1]], local $b = [$b->[1]])
        }
        join q(), map @$_, sort recursive_sort ([1,2], [1,1], [2,1], [2,0])
EOCODE
    ;


