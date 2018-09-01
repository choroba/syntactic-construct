
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct 'lexical-$_';
expect_known_construct 'lexical-default-variable';

expect_construct_in_perl
    '5.010' => is_supported,
    '5.012' => is_supported,
    '5.014' => is_supported,
    '5.016' => is_supported,
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => isnt_supported,
    '5.026' => isnt_supported,
    '5.028' => isnt_supported,
    ;

syntax_error_when_unsupported qr/Can't use global \$_ in "my"/;

expect_sample_code
    returns_when_supported => 7,
    code => <<'EOCODE',
        $_ = 7;
        { my $_ = 42; }
        $_
EOCODE
    ;

