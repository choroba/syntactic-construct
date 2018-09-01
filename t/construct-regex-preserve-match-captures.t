
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 5;
use Test::Warnings;

expect_known_construct '/p';
expect_known_construct 'regex-preserve-match-captures';

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
    returns_when_supported => undef,
    returns_when_unsupported => undef,
    code => <<'EOCODE',
        "abc" =~ m/b/;
        ${^PREMATCH};
EOCODE
    ;

expect_sample_code
    returns_when_supported => 'a',
    syntax_error_when_unsupported => qr/syntax error at .eval/,
    code => <<'EOCODE',
        "abc" =~ m/b/p;
        ${^PREMATCH};
EOCODE
    ;

