
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Warnings;

expect_known_construct 'keys-array';

expect_construct_in_perl
    '5.012' => is_supported,
    '5.014' => is_supported,
    '5.016' => is_supported,
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/must be hash/;

expect_sample_code
    returns_when_supported => '012',
    code => <<'EOCODE',
        my @array = qw( a b c );
        join '',  keys @array;
EOCODE
    ;

