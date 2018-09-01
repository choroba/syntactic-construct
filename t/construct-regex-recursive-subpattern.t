
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 5;
use Test::Warnings;

expect_known_construct '?PARNO';
expect_known_construct 'regex-recursive-subpattern';

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

syntax_error_when_unsupported qr/Sequence .* not recognized in regex/;

expect_sample_code
    returns_when_supported => 'dab',
    code => <<'EOCODE',
        my (undef, $content) = "adabaad" =~ m/^(a+(?=d))(.*?)(?1)/;
        $content;
EOCODE
    ;

# from perlre
expect_sample_code
    returns_when_supported => [ 'foo(bar(baz)+baz(bop))', '(bar(baz)+baz(bop))', 'bar(baz)+baz(bop)' ],
    code => <<'EOCODE',
        my $re = qr{ (        # paren group 1 (full function)
            foo
            (                 # paren group 2 (parens)
              \(
                (             # paren group 3 (contents of parens)
                (?:
                 (?> [^()]+ ) # Non-parens without backtracking
                |
                 (?2)         # Recurse to start of paren group 2
                )*
                )
              \)
            )
          )
        }x;
        [ 'foo(bar(baz)+baz(bop))' =~ $re ];
EOCODE
    ;

