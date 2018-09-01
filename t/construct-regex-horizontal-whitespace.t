
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 6;
use Test::Warnings;

expect_known_construct '\h';
expect_known_construct '\H';
expect_known_construct 'regex-horizontal-whitespace';

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
    returns_when_supported => [ "\x20", "\x09", "\x{2002}" ],
    returns_when_unsupported => [ "h" ],
    warning_when_unsupported => qr/Unrecognized escape \\h/,
    code => <<'EOCODE',
        [ grep m/^\h$/, "\x0a", "\x0d", "\x20", "\x09", "\x{2002}", "h", "H" ]
EOCODE
    ;

expect_sample_code
    returns_when_supported => [ "\x0a", "\x0d", "h", "H" ],
    returns_when_unsupported => [ "H" ],
    warning_when_unsupported => qr/Unrecognized escape \\H/,
    code => <<'EOCODE',
        [ grep m/^\H$/, "\x0a", "\x0d", "\x20", "\x09", "\x{2002}", "h", "H" ]
EOCODE
    ;

