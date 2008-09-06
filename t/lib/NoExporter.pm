package NoExporter;
# $Id: /mirror/googlecode/test-more/t/lib/NoExporter.pm 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

$VERSION = 1.02;
sub import { 
    shift;
    die "NoExporter exports nothing.  You asked for: @_" if @_;
}

1;

