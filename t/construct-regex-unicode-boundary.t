
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use FindBin;
use Test::More tests => 1 + 10;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct '\b{}';
expect_known_construct '\b{gcb}';
expect_known_construct '\b{wb}';
expect_known_construct '\b{sb}';
expect_known_construct 'regex-unicode-boundary';
expect_known_construct 'regex-unicode-grapheme-cluster-boundary';
expect_known_construct 'regex-unicode-word-boundary';
expect_known_construct 'regex-unicode-sentence-boundary';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => [ "O'Connor", ",", "Sarah" ],
    $] < 5.020
        ? ( returns_when_unsupported => [ "O'Connor,Sarah" ] )
        : ( syntax_error_when_unsupported => qr/\\b\\\{/x )
        ,
    code => <<'EOCODE',
        [ split m/\b{wb}/, "O'Connor,Sarah" ]
EOCODE
    ;

