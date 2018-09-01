
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use FindBin;
use Test::More tests => 1 + 5;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct '<<>>';
expect_known_construct 'double-diamond';
expect_known_construct 'operator-double-diamond';

expect_construct_in_perl
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/syntax error at .* near ">>/;

expect_sample_code
    returns_when_supported => "Sample line",
    code => <<'EOCODE',
        local @ARGV = ("$FindBin::Bin/data/sample-line.txt");
        my $line;
        chomp ($line = <<>>);
        $line;
EOCODE
    ;
