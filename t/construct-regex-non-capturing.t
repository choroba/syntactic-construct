
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use FindBin;
use Test::More tests => 1 + 4;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct '/n';
expect_known_construct 'regex-non-capturing';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported
    $] < 5.018
        ? qr/syntax error at .* near "m\//
        : qr/Unknown regexp modifier "\/n/
    ;

expect_sample_code
    returns_when_supported => undef,
    code => <<'EOCODE',
        "abc" =~ m/(.)/n;
        $1;
EOCODE
    ;
