use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Syntax::Construct',
    AUTHOR           => q{E. Choroba <choroba@cpan.org>},
    VERSION_FROM     => 'lib/Syntax/Construct.pm',
    ABSTRACT_FROM    => 'lib/Syntax/Construct.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    macro => { TARFLAGS => '--format=ustar -cvf' },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Syntax-Construct-*' },
);
