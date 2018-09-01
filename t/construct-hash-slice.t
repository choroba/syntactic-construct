
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct '%slice';
expect_known_construct 'hash-slice';

expect_construct_in_perl
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => 'a:A:b:B',
    syntax_error_when_unsupported => qr/syntax error .* near "\%h\{/,
    code => <<'EOCODE',
        my %h = qw(a A b B);
        join ":", %h{qw(a b)};
EOCODE
    ;

