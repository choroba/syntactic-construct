
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct '()x=';
expect_known_construct 'list-repetition-assignment';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Can't modify repeat/;

expect_sample_code
    returns_when_supported => [ 3, 4 ],
    code => <<'EOCODE',
        ((undef) x 2, my @x) = 1 .. 4;
        \@x;
EOCODE
    ;

