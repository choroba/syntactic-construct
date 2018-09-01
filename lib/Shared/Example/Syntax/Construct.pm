
use strict;
use warnings;

package Shared::Example::Syntax::Construct;

our $VERSION = '1.007';

use parent 'Exporter::Tiny';

require Syntax::Construct;

use Test::More v0.96;
use Test::Deep qw[];
use version;

our @EXPORT = (
    qw[ expect_construct_in_perl ],
    qw[ expect_known_construct ],
    qw[ expect_sample_code ],
    qw[ is_supported ],
    qw[ isnt_supported ],
    qw[ syntax_error_when_unsupported ],
);

our $SAMPLE_CODE;
our @SYNTAX_CONSTRUCT;

our $SYNTAX_ERROR;

my @PERL_VERSIONS = (
    '5.006',
    '5.008',
    '5.010',
    '5.012',
    '5.014',
    '5.016',
    '5.018',
    '5.020',
    '5.022',
    '5.024',
    '5.026',
    '5.028',
);

use constant is_supported => 1;
use constant isnt_supported => 0;

sub _expect_it_isnt_supported {
    my ($version) = @_;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $ok = !! @SYNTAX_CONSTRUCT;
    for my $construct (@SYNTAX_CONSTRUCT) {
        my $is_supported = Syntax::Construct::_is_supported ($construct, $version);

        my $this_ok = ok ! $is_supported, "version $version shouldn't support '$construct'";
        $ok &&= $this_ok;
    }

    return $ok;
}

sub _expect_it_is_supported {
    my ($version) = @_;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $ok = !! @SYNTAX_CONSTRUCT;
    for my $construct (@SYNTAX_CONSTRUCT) {
        my $is_supported = Syntax::Construct::_is_supported ($construct, $version);

        my $this_ok = ok $is_supported, "version $version should support construct '$construct'";
        $ok &&= $this_ok;
    }

    return $ok;
}

sub expect_construct_in_perl {
    my (%params) = @_;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    for my $predefined (@PERL_VERSIONS) {
        $params{$predefined} = isnt_supported
            unless exists $params{$predefined};
    }

    my @test_versions = sort keys %params;

    subtest "construct support map" => sub {
        plan tests => @test_versions * @SYNTAX_CONSTRUCT;
        for my $version (@test_versions) {
            $params{$version}
                ? _expect_it_is_supported   $version
                : _expect_it_isnt_supported $version
                ;
        }
    };
}

sub syntax_error_when_unsupported {
    my ($test) = @_;

    $SYNTAX_ERROR = $test;
}

sub expect_sample_code {
    my (%params) = @_;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $is_supported = Syntax::Construct::_is_supported ($SYNTAX_CONSTRUCT[0]);

    my $warning;
    local $SIG{__WARN__} = sub { $warning = shift };
    my $got = eval $params{code};
    my $error = $@;

    if ($is_supported) {
        return Test::Deep::cmp_deeply $error, Test::Deep::re ($params{throws_when_unsupported}), "sample code should throw on current perl $]"
            if exists $params{throws_when_unsupported};

        return Test::Deep::cmp_deeply $got, $params{returns_when_supported}, "sample code should pass on current perl $]";
    }

    $params{syntax_error_when_unsupported} = $SYNTAX_ERROR
        unless exists $params{syntax_error_when_unsupported};

    if (my $expected = $params{syntax_error_when_unsupported}) {
        return Test::Deep::cmp_deeply
            $error,
            ('Regexp' eq ref $expected)
                ? Test::Deep::re ($expected)
                : Test::Deep::bool ($expected),
            "sample code should cause syntax error on current perl $]"
            ;
    }

    if (my $expected = $params{warning_when_unsupported}) {
        return Test::Deep::cmp_deeply
            $warning,
            ('Regexp' eq ref $expected)
                ? Test::Deep::re ($expected)
                : Test::Deep::bool ($expected),
            "sample code should produce warning on current perl $]"
            ;
    }

    if ($error) {
        fail "Normal exit expected but sample code died";
        diag $error;
        return;
    }

    return Test::Deep::cmp_deeply $got, $params{returns_when_unsupported}, "sample code shouldn't pass on current perl $]"
        if exists $params{returns_when_unsupported};

    return fail "expect_sample_code should describe behavior when construct is not supported";
}

sub expect_known_construct {
    my ($construct) = @_;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $known = eval { Syntax::Construct::_ensure_known_construct ($construct); 1 };
    my $error = $@;
    $error =~ s{ at .*Syntax/Construct.pm line \d+}{};

    ok $known, "expect valid syntax construct '$construct'"
        or diag $error;

    push @SYNTAX_CONSTRUCT, $construct;
}

1;

__END__

=pod

=head1 NAME

Shared::Example::Syntax::Construct

=head1 DESCRIPTION

Shared examples to test L<< Syntax::Construct >>

=head2 expect_construct_in_perl MAP

    expect_known_construct 'foo';
    expect_construct_in_perl
        '5.090' => is_supported,
        ;

Test that known construct(s) is supported by enumerated perl versions.

Unlisted version listed in @PERL_VERSIONS internal variable is treated as C<< isnt_supported >>.

Acts as one test (with subtests).

=head2 expect_known_construct CONSTRUCT

Test that construct is known by L<< Syntax::Construct >>.

Value will be stored and reused in C<< expect_construct_in_perl >>.

Acts as one test.

=head2 expect_sample_code

Test how code snippet should behave when syntax construct is supported and when it is not.

    expect_sample_code
        returns_when_supported => ...,
        returns_when_unsupported => ...,
        warning_when_unsupported => ...,
        syntax_error_when_unsupported => ...,
        code => ...
        ;

Evaluates given code and applies proper supported/unsupported test(s) if provided.
Test value is treated as L<< Test::Deep >> expectation.

Acts as one test.

=head2 is_supported

=head2 isnt_supported

Syntax sugar functions to make C<< expect_construct_in_perl >> arguments little bit more readable.

=head2 syntax_error_when_unsupported EXPR

Default expression shared between all code samples to describe behaviour when construct is not supported.

=cut

