
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct '/xx';
expect_known_construct 'regex-xx';

expect_construct_in_perl
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => "a",
    returns_when_unsupported => "a b",
    code => <<'EOCODE',
        "a b" =~ m/( [a b]+ )/xx;
        $1;
EOCODE
    ;

