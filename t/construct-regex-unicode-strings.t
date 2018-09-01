
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct '/u';
expect_known_construct 'regex-unicode-strings';

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

syntax_error_when_unsupported qr/syntax error at .eval/;

expect_sample_code
    returns_when_supported => bool (1),
    code => <<'EOCODE',
        "\xa0\xe0" =~ /\w/u
EOCODE
    ;
