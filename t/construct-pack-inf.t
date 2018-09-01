
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 5;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct 'chr-inf';
expect_known_construct 'pack-inf';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    throws_when_supported => qr/Cannot chr Inf/,
    returns_when_unsupported => bool (1),
    code => <<'EOCODE',
        defined chr "Inf";
EOCODE
    ;

expect_sample_code
    throws_when_supported => qr/Cannot pack Inf/,
    returns_when_unsupported => bool (1),
    code => <<'EOCODE',
        defined pack "C", "Inf";
EOCODE
    ;

