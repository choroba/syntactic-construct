
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use utf8;
use Test::More tests => 1 + 4;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct 's-utf8-delimiters';
expect_known_construct 'wide-char-delimiters';

expect_construct_in_perl
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Substitution replacement not terminated/;

expect_sample_code
    returns_when_supported => "b",
    code => <<'EOCODE',
        my $var = "a";
        $var =~ s«a«b«;
        $var;
EOCODE
    ;
