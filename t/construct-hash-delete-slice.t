
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct 'delete%';
expect_known_construct 'hash-delete-slice';

expect_construct_in_perl
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported
    $] < 5.010
        ? qr/syntax error .* near "\%h\{/
        :
    $] < 5.020
        ? qr/delete argument is not a HASH/
        : qr/delete argument is key\/value/
    ;

expect_sample_code
    returns_when_supported => { a => 12, b => 13 },
    code => <<'EOCODE',
        my %h = ( a => 12, b => 13, c => 14 );
        +{ delete %h{"a", "b"} };
EOCODE
    ;

