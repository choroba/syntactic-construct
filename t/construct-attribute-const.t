
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct 'attr-const';
expect_known_construct 'attribute-const';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Invalid CODE attribute/;

expect_sample_code
    returns_when_supported => [ 2, (1) x 10 ],
    code => <<'EOCODE',
        my $counter = 1;
        my $c = sub () :const { $counter ++ };
        # $counter is actually modified before function is called
        [ $counter, map $c->(), 1 .. 10 ];
EOCODE
    ;

