
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct '^CAPTURE';
expect_known_construct 'capture-variable';

expect_construct_in_perl
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => [ "a", "b" ],
    returns_when_unsupported => [ ],
    code => <<'EOCODE',
        "ab" =~ m/(.)(.)/;
        [ @{^CAPTURE} ];
EOCODE
    ;

