package Test::Stream::ArrayBase::Meta;
use strict;
use warnings;

use Test::Stream::Carp qw/confess/;

my %META;

sub package {     shift->{package}   }
sub parent  {     shift->{parent}    }
sub locked  {     shift->{locked}    }
sub fields  {({ %{shift->{fields}} })}

sub new {
    my $class = shift;
    my ($pkg) = @_;

    $META{$pkg} ||= bless {
        package => $pkg,
        locked  => 0,
    }, $class;

    return $META{$pkg};
}

sub get {
    my $class = shift;
    my ($pkg) = @_;

    return $META{$pkg};
}

sub baseclass {
    my $self = shift;
    $self->{parent} = 'Test::Stream::ArrayBase';
    $self->{index}  = 0;
    $self->{fields} = {};
}

sub subclass {
    my $self = shift;
    my ($parent) = @_;
    confess "Already a subclass of $self->{parent}! Tried to sublcass $parent" if $self->{parent};

    my $pmeta = $self->get($parent) || die "$parent is not an ArrayBase object!";
    $pmeta->{locked} = 1;

    $self->{parent} = $parent;
    $self->{index}  = $pmeta->{index};
    $self->{fields} = $pmeta->fields; #Makes a copy

    my $ex_meta = Test::Stream::Exporter::Meta->get($self->{package});

    # Put parent constants into the subclass
    for my $field (keys %{$self->{fields}}) {
        my $const = uc $field;
        no strict 'refs';
        *{"$self->{package}\::$const"} = $parent->can($const) || confess "Could not find constant '$const'!";
        $ex_meta->add($const);
    }
}

sub add_accessor {
    my $self = shift;
    my ($name) = @_;

    confess "Cannot add accessor, metadata is locked due to a subclass being initialized."
        if $self->{locked};

    confess "field '$name' already defined!"
        if exists $self->{fields}->{$name};

    my $idx = $self->{index}++;
    $self->{fields}->{$name} = $idx;

    my $const = uc $name;
    my $gname = lc $name;
    my $sname = "set_$gname";
    my $cname = "clear_$gname";

    eval qq|
        package $self->{package};
        sub $gname { \$_[0]->[$idx] }
        sub $sname { \$_[0]->[$idx] = \$_[1] }
        sub $cname { \$_[0]->[$idx] = undef  }
        sub $const() { $idx }
        1
    | || confess $@;

    # Add the constant as an optional export
    my $ex_meta = Test::Stream::Exporter::Meta->get($self->{package});
    $ex_meta->add($const);
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
