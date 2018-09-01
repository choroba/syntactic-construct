
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct '\p{Unicode}';
expect_known_construct 'regex-property-unicode';

expect_construct_in_perl
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Can't find Unicode property definition/;

expect_sample_code
    returns_when_supported => 2,
    code => <<'EOCODE',
        scalar grep m/\p{Unicode}/, "a", "\N{U+0FFFFF}"
EOCODE
    ;

