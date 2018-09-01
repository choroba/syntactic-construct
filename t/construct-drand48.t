
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Deep qw[ ignore ];
use Test::Warnings;

expect_known_construct 'drand48';

expect_construct_in_perl
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => [qw[ 744 342 111 422 81 856 498 478 690 834 462 577 533 25 769 601 908 489 535 496 ]],
    # even perl without internal drand48 can use it in case underlying libc provides it
    returns_when_unsupported => ignore,
    code => <<'EOCODE',
        srand 42;
        [ map int rand 1_000, 1 .. 20 ];
EOCODE
    ;

