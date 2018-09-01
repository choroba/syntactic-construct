
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 5;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct 'unicode7.0';
expect_known_construct 'unicode-7.0';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Can't find Unicode property definition/;

expect_sample_code
    returns_when_supported => 327,
    code => <<'EOCODE',
        scalar grep m/\p{Age: 7.0}/, map chr, 0 .. 0xffff;
EOCODE
    ;

expect_sample_code
    returns_when_supported => bool (1),
    code => <<'EOCODE',
        "\N{U+11600}" =~ m/\p{Modi}/;
EOCODE
    ;
