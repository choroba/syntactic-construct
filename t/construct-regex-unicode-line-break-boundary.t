
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use FindBin;
use Test::More tests => 1 + 4;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct '\b{lb}';
expect_known_construct 'regex-unicode-line-break-boundary';

expect_construct_in_perl
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => [ "11\n", "22" ],
    $] < 5.020
        ? ( returns_when_unsupported => [ "11\n22" ] )
        :
    $] < 5.022
        ? ( syntax_error_when_unsupported => qr/Use "\\b\\\{" instead of/ )
        : ( syntax_error_when_unsupported => qr/unknown bound type in regex/ )
        ,
    code => <<'EOCODE',
        [ split m/\b{lb}/, "11\n22" ]
EOCODE
    ;

