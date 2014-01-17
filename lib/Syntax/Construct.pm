package Syntax::Construct;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.02';


my %construct = (
                 'computed-labels' => v5.18,
                 'our-sub'         => v5.18,
                 'state-sub'       => v5.18,

                 '?^'              => v5.14,
                 '/r'              => v5.14,
                 '/d'              => v5.14,
                 '/l'              => v5.14,
                 '/u'              => v5.14,
                 '/a'              => v5.14,
                 'auto-deref'      => v5.14,
                 '^GLOBAL_PHASE'   => v5.14,

                 'package-version' => v5.12,
                 '...'             => v5.12,
                 'each-array'      => v5.12,
                 'keys-array'      => v5.12,
                 'values-array'    => v5.12,
                 'delete-local'    => v5.12,
                 'length-undef'    => v5.12,
                 '\N'              => v5.12,

                 '//'              => v5.10,
                 '?PARNO'          => v5.10,
                 '?<>'             => v5.10,
                 '?|'              => v5.10,
                 'quant+'          => v5.10,
                 'regex-verbs'     => v5.10,
                 '\K'              => v5.10,
                 '\R'              => v5.10,
                 '\gN'             => v5.10,
                 'readline()'      => v5.10,
                 'stack-file-test' => v5.10,
                 'recursive-sort'  => v5.10,
                 '/p'              => v5.10,
                );


sub _position {
    join ' line ', (caller(1))[1,2];
}


sub import {
    shift;
    my $version = v0;
    my $constr;
    for (@_) {
        if (exists $construct{$_}) {
            ($version, $constr) = ($construct{$_}, $_)
                if $construct{$_} gt $version;
        } else {
            die "Unknown construct `$_' at ", _position(), "\n";
        }
    }
    die 'Empty construct list at ', _position(), "\n" if $version eq v0;
    eval { require $version; 1 }
        or die "Unsupported construct $constr at ", _position(),
               sprintf " (Perl %vd)\n", $version;
}


=head1 NAME

Syntax::Construct - Identify which non-feature constructs are used in the code.

=head1 VERSION

Version 0.02

=head1 SYNOPSIS

For some new syntactic constructs, there is the L<feature> pragma. For
the rest, there is B<Syntax::Construct>.

  use Syntax::Construct qw( // ... /r );

  my $x = shift // 'default';
  my $y = $x =~ s/de(fault)/$1/r;
  if ($y =~ /^fault/) {
      ...
  }

=head1 EXPORT

Nothing. Using B<Syntax::Construct> with no parameters is an error,
giving it an empty list is a no-op.

=head1 RECOGNISED CONSTRUCTS

=head2 v5.10

=head3 recursive-sort

=head3 //

=head3 ?PARNO

=head3 ?<>

=head3 ?|

=head3 quant+

=head3 regex-verbs

=head3 \K

=head3 \R

=head3 \gN

=head3 readline()

=head3 stack-file-test

=head3 /p

=head2 v5.12

=head3 package-version

=head3 ...

=head3 each-array

=head3 keys-array

=head3 values-array

=head3 delete-local

=head3 length-undef

=head3 \N

=head2 v5.14

=head3 ?^

=head3 /r

=head3 /d

=head3 /l

=head3 /u

=head3 /a

=head3 auto-deref

=head3 ^GLOBAL_PHASE

=head2 v5.16

No constructs.

=head2 v5.18

=head3 computed-labels

=head3 our-sub

=head3 state-sub

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
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

__PACKAGE__
