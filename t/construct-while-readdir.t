
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 3;
use Test::Warnings;

expect_known_construct 'while-readdir';

expect_construct_in_perl
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

expect_sample_code
    returns_when_supported => 1,
    returns_when_unsupported => undef,
    warning_when_unsupported => qr/Use of uninitialized value .*in string eq/,
    code => <<'EOCODE',
        use FindBin;
        use File::Spec;
        opendir my $DIR, $FindBin::Bin or die $!;
        my $c = 0;
        $_ eq ("File::Spec"->splitpath($0))[-1] and ++$c
            while readdir $DIR;
        $c
EOCODE
    ;

