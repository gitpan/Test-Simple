# $Id: /mirror/googlecode/test-more/t/no_header.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $
BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't';
        @INC = '../lib';
    }
}

use Test::Builder;

# STDOUT must be unbuffered else our prints might come out after
# Test::More's.
$| = 1;

BEGIN {
    Test::Builder->new->no_header(1);
}

use Test::More tests => 1;

print "1..1\n";
pass;
