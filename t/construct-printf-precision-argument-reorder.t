
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use FindBin;
use Test::More tests => 1 + 5;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct 'sprintf-reorder';
expect_known_construct 'printf-precision-argument-reorder';
expect_known_construct 'sprintf-precision-argument-reorder';

expect_construct_in_perl
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => "|007|",
    returns_when_unsupported => '|%.*2$d|',
    warning_when_unsupported =>
        $] < 5.022
            ? qr/Invalid conversion in sprintf/
            : qr/Redundant argument in sprintf/
            ,
    code => <<'EOCODE',
        sprintf q(|%.*2$d|), 7, 3;
EOCODE
    ;

