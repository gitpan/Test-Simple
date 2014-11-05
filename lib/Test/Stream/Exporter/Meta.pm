package Test::Stream::Exporter::Meta;
use strict;
use warnings;

use Test::Stream::PackageUtil;

# Test::Stream::Carp uses this module.
sub croak   { require Carp; goto &Carp::croak }
sub confess { require Carp; goto &Carp::confess }

sub exports { $_[0]->{exports} }
sub default { @{$_[0]->{pdlist}} }
sub all     { @{$_[0]->{polist}} }

sub add {
    my $self = shift;
    my ($name, $ref) = @_;

    confess "Name is mandatory" unless $name;

    confess "$name is already exported"
        if $self->exports->{$name};

    $ref ||= package_sym($self->{package}, CODE => $name);

    confess "No reference or package sub found for '$name' in '$self->{package}'"
        unless $ref && ref $ref;

    $self->exports->{$name} = $ref;
    push @{$self->{polist}} => $name;
}

sub add_default {
    my $self = shift;
    my ($name, $ref) = @_;

    $self->add($name, $ref);
    push @{$self->{pdlist}} => $name;

    $self->{default}->{$name} = 1;
}

my %EXPORT_META;

sub new {
    my $class = shift;
    my ($pkg) = @_;

    confess "Package is required!"
        unless $pkg;

    $EXPORT_META{$pkg} ||= bless({
        exports => {},
        default => {},
        pdlist  => do { no strict 'refs'; no warnings 'once'; \@{"$pkg\::EXPORT"} },
        polist  => do { no strict 'refs'; no warnings 'once'; \@{"$pkg\::EXPORT_OK"} },
        package => $pkg,
    }, $class);

    return $EXPORT_META{$pkg};
}

sub get {
    my $class = shift;
    my ($pkg) = @_;

    confess "Package is required!"
        unless $pkg;

    return $EXPORT_META{$pkg};
}

1;

__END__

=encoding utf8

=head1 SOURCE

The source code repository for Test::More can be found at
F<http://github.com/Test-More/test-more/>.

=head1 MAINTAINER

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=back

=head1 AUTHORS

The following people have all contributed to the Test-More dist (sorted using
VIM's sort function).

=over 4

=item Chad Granum E<lt>exodist@cpan.orgE<gt>

=item Fergal Daly E<lt>fergal@esatclear.ie>E<gt>

=item Mark Fowler E<lt>mark@twoshortplanks.comE<gt>

=item Michael G Schwern E<lt>schwern@pobox.comE<gt>

=item 唐鳳

=back

=head1 COPYRIGHT

=over 4

=item Test::Stream

=item Test::Tester2

Copyright 2014 Chad Granum E<lt>exodist7@gmail.comE<gt>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See F<http://www.perl.com/perl/misc/Artistic.html>

=item Test::Simple

=item Test::More

=item Test::Builder

Originally authored by Michael G Schwern E<lt>schwern@pobox.comE<gt> with much
inspiration from Joshua Pritikin's Test module and lots of help from Barrie
Slaymaker, Tony Bowden, blackstar.co.uk, chromatic, Fergal Daly and the perl-qa
gang.

Idea by Tony Bowden and Paul Johnson, code by Michael G Schwern
E<lt>schwern@pobox.comE<gt>, wardrobe by Calvin Klein.

Copyright 2001-2008 by Michael G Schwern E<lt>schwern@pobox.comE<gt>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See F<http://www.perl.com/perl/misc/Artistic.html>

=item Test::use::ok

To the extent possible under law, 唐鳳 has waived all copyright and related
or neighboring rights to L<Test-use-ok>.

This work is published from Taiwan.

L<http://creativecommons.org/publicdomain/zero/1.0>

=item Test::Tester

This module is copyright 2005 Fergal Daly <fergal@esatclear.ie>, some parts
are based on other people's work.

Under the same license as Perl itself

See http://www.perl.com/perl/misc/Artistic.html

=item Test::Builder::Tester

Copyright Mark Fowler E<lt>mark@twoshortplanks.comE<gt> 2002, 2004.

This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=back
