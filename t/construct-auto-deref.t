
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Deep qw[ any re ];
use Test::Warnings;

expect_known_construct 'auto-deref';

expect_construct_in_perl
    '5.014' => is_supported,
    '5.016' => is_supported,
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => isnt_supported,
    '5.026' => isnt_supported,
    '5.028' => isnt_supported,
    ;

syntax_error_when_unsupported qr/Experimental push on scalar is now forbidden/
    if $] >= 5.024;

syntax_error_when_unsupported qr/Type of arg 1 to push must be array/
    if $] < 5.014;

expect_sample_code
    returns_when_supported => "10:20:30",
    code => <<'EOCODE',
        my $array = [ 10, 20 ];
        push $array, 30;
        join ':', @$array;
EOCODE
    ;

