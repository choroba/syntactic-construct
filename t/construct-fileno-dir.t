
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct 'fileno-dir';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => bool (1),
    returns_when_unsupported => bool (0),
    code => <<'EOCODE',
        opendir my $D, ".";
        defined fileno $D;
EOCODE
    ;

