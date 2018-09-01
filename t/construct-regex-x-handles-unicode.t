
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 5;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct '/x-unicode';
expect_known_construct 'regex-x-unicode';
expect_known_construct 'regex-x-handles-unicode';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => bool (1),
    returns_when_unsupported => bool (0),
    code => <<'EOCODE',
        my $s = " \N{U+0085}\N{U+200E}\N{U+200F}\N{U+2028}\N{U+2029}";
        "ab" =~ m/a${s}b/x;
EOCODE
    ;

