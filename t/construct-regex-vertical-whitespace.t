
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 6;
use Test::Warnings;

expect_known_construct '\v';
expect_known_construct '\V';
expect_known_construct 'regex-vertical-whitespace';

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
    returns_when_supported => [ "\x0a", "\x0d" ],
    returns_when_unsupported => [ "v" ],
    warning_when_unsupported => qr/Unrecognized escape \\v/,
    code => <<'EOCODE',
        [ grep m/^\v$/, "\x0a", "\x0d", "\x20", "\x09", "\x{2002}", "v", "V" ]
EOCODE
    ;

expect_sample_code
    returns_when_supported => [ "\x20", "\x09", "\x{2002}", "v", "V" ],
    returns_when_unsupported => [ "V" ],
    warning_when_unsupported => qr/Unrecognized escape \\V/,
    code => <<'EOCODE',
        [ grep m/^\V$/, "\x0a", "\x0d", "\x20", "\x09", "\x{2002}", "v", "V" ]
EOCODE
    ;

