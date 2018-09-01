
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct 'attr-prototype';
expect_known_construct 'attribute-prototype';

expect_construct_in_perl
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Invalid CODE attribute/;

expect_sample_code
    returns_when_supported => '$$',
    code => <<'EOCODE',
        sub func : prototype($$) {}
        prototype \& func;
EOCODE
    ;

