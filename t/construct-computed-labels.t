
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Warnings;

expect_known_construct 'computed-labels';

expect_construct_in_perl
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Label not found/;

expect_sample_code
    returns_when_supported => '1',
    code => <<'EOCODE',
        my $x = 'A';
        B: while (1) {
            A: while (1) {
                last $x++
            }
        }
        1
EOCODE
    ;

