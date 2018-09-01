
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Deep qw[ num ];
use Test::Warnings;

expect_known_construct 'hexfloat';
expect_known_construct 'hexadecimal-floating-numbers';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/syntax error/;

expect_sample_code
    returns_when_supported => num (3.14, 0.01),
    code => <<'EOCODE',
        0x3_23D_70A_3D7_0A_p-44;
EOCODE
    ;

