package Syntax::Construct;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.16';


my %construct = (
                 '<<>>'            => 5.022,
                 '\\b{}'           => 5.022,
                 '/n'              => 5.022,
                 'unicode7.0'      => 5.022,
                 ':const'          => 5.022,
                 'fileno-dir'      => 5.022,
                 '()x='            => 5.022,
                 'hexfloat'        => 5.022,
                 'chr-inf'         => 5.022,
                 'empty-slice'     => 5.022,
                 '/x-unicode'      => 5.022,

                 ':prototype'      => 5.020,
                 'drand48'         => 5.020,
                 '%slice'          => 5.020,
                 'unicode6.3'      => 5.020,
                 '\p{Unicode}'     => 5.020,
                 'utf8-locale'     => 5.020,

                 'computed-labels' => 5.018,

                 '?^'              => 5.014,
                 '/r'              => 5.014,
                 '/d'              => 5.014,
                 '/l'              => 5.014,
                 '/u'              => 5.014,
                 '/a'              => 5.014,
                 'auto-deref'      => 5.014,
                 '^GLOBAL_PHASE'   => 5.014,
                 '\o'              => 5.014,
                 'package-block'   => 5.014,

                 'package-version' => 5.012,
                 '...'             => 5.012,
                 'each-array'      => 5.012,
                 'keys-array'      => 5.012,
                 'values-array'    => 5.012,
                 'delete-local'    => 5.012,
                 'length-undef'    => 5.012,
                 '\N'              => 5.012,
                 'while-readdir'   => 5.012,

                 '//'              => 5.010,
                 '?PARNO'          => 5.010,
                 '?<>'             => 5.010,
                 '?|'              => 5.010,
                 'quant+'          => 5.010,
                 'regex-verbs'     => 5.010,
                 '\K'              => 5.010,
                 '\R'              => 5.010,
                 '\gN'             => 5.010,
                 'readline()'      => 5.010,
                 'stack-file-test' => 5.010,
                 'recursive-sort'  => 5.010,
                 '/p'              => 5.010,
                );


sub _position {
    join ' line ', (caller(1))[1,2];
}


sub import {
    shift;
    my $version = 0;
    my $constr;
    for (@_) {
        if (exists $construct{$_}) {
            ($version, $constr) = ($construct{$_}, $_)
                if $construct{$_} > $version;
        } else {
            die "Unknown construct `$_' at ", _position(), "\n";
        }
    }
    die 'Empty construct list at ', _position(), "\n" if $version == 0;
    eval { require $version; 1 }
        or die "Unsupported construct $constr at ", _position(),
               sprintf " (Perl %.3f)\n", $version;
}


=head1 NAME

Syntax::Construct - Identify which non-feature constructs are used in the code.

=head1 VERSION

Version 0.16

=head1 SYNOPSIS

For some new syntactic constructs, there is the L<feature> pragma. For
the rest, there is B<Syntax::Construct>.

  use Syntax::Construct qw( // ... /r );

  my $x = shift // 'default';
  my $y = $x =~ s/de(fault)/$1/r;
  if ($y =~ /^fault/) {
      ...
  }

=head1 DESCRIPTION

This module provides a simple way of specifying syntactic constructs
that are not implemented via the L<feature> pragma, but are still not
compatible with older versions of Perl.

=head1 EXPORT

Nothing. Using B<Syntax::Construct> with no parameters is an error,
giving it an empty list is a no-op.

=head1 RECOGNISED CONSTRUCTS

=head2 5.010

=head3 recursive-sort

L<perl5100delta/Recursive sort subs>.

=head3 //

L<perl5100delta/Defined-or operator> or L<perlop/Logical Defined-Or>.

=head3 ?PARNO

"Recursive Patterns" under L<perl5100delta/Regular expressions> or
L<perlre/"(?PARNO) (?-PARNO) (?+PARNO) (?R) (?0)">.

=head3 ?<>

"Named Capture Buffers" under L<perl5100delta/Regular expressions> or
L<perlre/"(?E<60>NAMEE<62>pattern)">.


=head3 ?|

Not mentioned in any Delta. See B<(?|pattern)> in L<perlre/Extended patterns>.

=head3 quant+

"Possessive Quantifiers" under L<perl5100delta/Regular expressions> or
L<perlre/Quantifiers>.

=head3 regex-verbs

"Backtracking control verbs" under L<perl5100delta/Regular
expressions> or L<perlre/Special Backtracking Control Verbs>.


=head3 \K

"\K escape" under L<perl5100delta/Regular expressions> or
L<perlre/Look-Around Assertions>.

=head3 \R

"Vertical and horizontal whitespace, and linebreak" under
L<perl5100delta/Regular expressions> or L<perlrebackslash/Misc>.

=head3 \gN

"Relative backreferences" under L<perl5100delta/Regular expressions> or
L<perlre/Capture groups>.

=head3 readline()

L<perl5100delta/Default argument for readline()>.

=head3 stack-file-test

L<perl5100delta/Stacked filetest operators>.

=head3 /p

C</p> (preserve) modifier and C<${^PREMATCH}>, C<${^MATCH}> and
C<${^POSTMATCH}> variables. Not mentioned in any Delta. See
L<perlvar/Variables related to regular expressions>.

=head2 5.012

=head3 package-version

L<perl5120delta/New package NAME VERSION syntax>

=head3 ...

L<perl5120delta/The ... operator> or L<perlsyn/The Ellipsis Statement>

=head3 each-array

L<perl5120delta/each, keys, values are now more flexible>

=head3 keys-array

L<perl5120delta/each, keys, values are now more flexible>

=head3 values-array

L<perl5120delta/each, keys, values are now more flexible>

=head3 delete-local

L<perl5120delta/delete local>

=head3 length-undef

See the ninth bullet in L<perl5120delta/Other potentially incompatible
changes>.

=head3 \N

L<perl5120delta/\N experimental regex escape>.

=head3 while-readdir

C<readdir> in a while-loop condition populates C<$_>. Not mentioned in
any delta, but see C<readdir> in L<perlfunc>.

=head2 5.014

=head3 ?^

L<perl5140delta/Regular Expressions>.

=head3 /r

L<perl5140delta/Regular Expressions> and L<perlre/Modifiers>.

=head3 /d

L<perl5140delta/Regular Expressions> and L<perlre/Modifiers>.

=head3 /l

L<perl5140delta/Regular Expressions> and L<perlre/Modifiers>.

=head3 /u

L<perl5140delta/Regular Expressions> and L<perlre/Modifiers>.

=head3 /a

L<perl5140delta/Regular Expressions> and L<perlre/Modifiers>.

=head3 auto-deref

L<perl5140delta/Array and hash container functions accept
references>. See also C<push>, C<pop>, C<shift>, C<unshift>,
C<splice>, C<keys>, C<values>, and C<each> in L<perlfunc>.

=head3 ^GLOBAL_PHASE

See B<New global variable ${^GLOBAL_PHASE}> under
L<perl5140delta/Other Enhancements>.

=head3 \o

L<perl5140delta/Regular-expressions>.

=head3 package-block

See B<package block syntax> under L<perl5140delta/Syntactical Enhancements>.

=head2 5.016

No non-feature constructs were introduced in this version of Perl.

=head2 5.018

=head3 computed-labels

L<perl5180delta/Computed Labels>

=head2 5.020

=head3 :prototype

L<perl5200delta/subs now take a prototype attribute>

=head3 drand48

L<perl5200delta/rand now uses a consistent random number generator>

=head3 %slice

L<perl5200delta/New slice syntax>

=head3 unicode6.3

L<perl5200delta/Unicode 6.3 now supported>

=head3 \p{Unicode}

See B<New \p{Unicode} regular expression pattern property> in
L<perl5200delta/Core Enhancements>.

=head3 utf8-locale

L<perl5200delta/use locale now works on UTF-8 locales>

=head2 5.022

=head3 <<>>

L<perldelta/New double diamond operator>

=head3 \\b{}

L<perldelta/New b boundaries in regular expressions>

=head3 /n

L<perldelta/Non Capturing Regular Expression Flag>

=head3 unicode7.0

L<perldelta/Unicode 7.0 with correction is now supported>

=head3 :const

L<perldelta/New :const subroutine attribute>

=head3 fileno-dir

L<perldelta/fileno now works on directory handles>

=head3 ()x=

L<perldelta/Assignment to list repetition>

=head3 hexfloat

L<perldelta/Floating point parsing has been improved>

=head3 chr-inf

L<perldelta/Packing infinity or not a number into a character is now fatal>

=head3 empty-slice

L<perldelta/List slices returning empty lists>

=head3 /x-unicode

L<perldelta/qr foo x now ignores all Unicode pattern white space>


=head1 AUTHOR

E. Choroba, C<< <choroba at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-syntax-construct at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Syntax-Construct>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

You can also use GitHub, see below.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Syntax::Construct


You can also look for information at:

=over 4

=item * GitHub Repository

L<https://github.com/choroba/syntactic-construct>

Feel free to report issues and submit pull requests.

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Syntax-Construct>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Syntax-Construct>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Syntax-Construct>

=item * Search CPAN

L<http://search.cpan.org/dist/Syntax-Construct/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 - 2014 E. Choroba.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

__PACKAGE__
