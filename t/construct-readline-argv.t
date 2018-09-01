
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct 'readline()';
expect_known_construct 'readline-argv';

expect_construct_in_perl
    '5.010' => is_supported,
    '5.012' => is_supported,
    '5.014' => is_supported,
    '5.016' => is_supported,
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Modification of a read-only value/;

expect_sample_code
    returns_when_supported => "readline default",
    returns_when_unsupported => [ "v" ],
    code => <<'EOCODE',
        local *ARGV = *main::DATA{IO};
        chomp (my $x = readline());
        $x
EOCODE
    ;

__DATA__
readline default
