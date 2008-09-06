package TieOut;
# $Id: /mirror/googlecode/test-more/t/lib/TieOut.pm 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

sub TIEHANDLE {
    my $scalar = '';
    bless( \$scalar, $_[0]);
}

sub PRINT {
    my $self = shift;
    $$self .= join('', @_);
}

sub PRINTF {
    my $self = shift;
    my $fmt  = shift;
    $$self .= sprintf $fmt, @_;
}

sub FILENO {}

sub read {
    my $self = shift;
    my $data = $$self;
    $$self = '';
    return $data;
}

1;
