
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Deep;
use Test::Warnings;

expect_known_construct '?^';
expect_known_construct 'regex-use-default-modifiers';

expect_construct_in_perl
    '5.014' => is_supported,
    '5.016' => is_supported,
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Sequence .* not recognized/;

expect_sample_code
    returns_when_supported => bool (0),
    code => <<'EOCODE',
        "Ab" =~ m/(?^)a/i
EOCODE
    ;

