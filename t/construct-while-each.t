
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Warnings;

expect_known_construct 'while-each';

expect_construct_in_perl
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => 1,
    returns_when_unsupported => 0,
    warning_when_unsupported => qr/Use of uninitialized value/,
    code => << 'EOCODE'
        my %h = qw( A a B b C c ); my ($k, $v);
        $k .= $_, $v .= $h{$_} while each %h;
        $k =~ /^[ABC]{3}$/ && $v =~ /^[abc]{3}$/
            ? 1
            : 0
            ;
EOCODE
    ;

