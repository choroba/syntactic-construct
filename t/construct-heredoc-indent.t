
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct '<<~';
expect_known_construct 'heredoc-indent';

expect_construct_in_perl
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/syntax error .* near "<?<~"/;

expect_sample_code
    returns_when_supported => "a\n",
    code => <<'EOCODE',
        <<~ 'EOSAMPLE'
        a
        EOSAMPLE
EOCODE
    ;

