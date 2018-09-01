
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct 'empty-slice';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => [ ],
    returns_when_unsupported => [ ],
    code => <<'EOCODE',
        [ ()[1..3] ];
EOCODE
    ;

expect_sample_code
    returns_when_supported => [ undef, undef, undef ],
    returns_when_unsupported => [ ],
    code => <<'EOCODE',
        [ (1)[1..3] ];
EOCODE
    ;

