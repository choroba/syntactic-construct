
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct '\R';
expect_known_construct 'regex-generic-linebreak';

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
    returns_when_supported => [ "\x0a", "\x0d", "\x0d\x0a" ],
    returns_when_unsupported => [ "R" ],
    warning_when_unsupported => qr/Unrecognized escape \\R/,
    code => <<'EOCODE',
        [ grep m/^\R$/, "\x0a", "\x0d", "\x0d\x0a", "R", "\x0a\x0d" ]
EOCODE
    ;

