
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct 'unicode-scx';

expect_construct_in_perl
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => bool (0),
    returns_when_unsupported => bool (1),
    code => <<'EOCODE',
        # KATAKANA-HIRAGANA DOUBLE HYPHEN => available since 5.14
        "\N{U+030A0}" =~ m/\p{Common}/;
EOCODE
    ;

