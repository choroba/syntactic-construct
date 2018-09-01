
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 5;
use Test::Warnings;

expect_known_construct 'state@=';
expect_known_construct 'state-array';
expect_known_construct 'state-hash';

expect_construct_in_perl
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported
    $] < 5.010
        ? qr/syntax error .* near "\%h\{/
        : qr/Initialization of state variables in list context/,
    ;

SKIP: {
    skip "feature state not supported by $]", 1 if $] < 5.010;
    expect_sample_code
        returns_when_supported => [ 1, 2 ],
        code => <<'EOCODE',
            use feature 'state';
            [ sub { state @x = (1 .. 2); @x }->() ];
EOCODE
    ;
}


