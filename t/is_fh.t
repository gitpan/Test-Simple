#!/usr/bin/perl -w
# $Id: /mirror/googlecode/test-more/t/is_fh.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't';
        @INC = ('../lib', 'lib');
    }
    else {
        unshift @INC, 't/lib';
    }
}

use strict;
use Test::More tests => 11;
use TieOut;

ok( !Test::Builder->is_fh("foo"), 'string is not a filehandle' );
ok( !Test::Builder->is_fh(''),    'empty string' );
ok( !Test::Builder->is_fh(undef), 'undef' );

ok( open(FILE, '>foo') );
END { close FILE; 1 while unlink 'foo' }

ok( Test::Builder->is_fh(*FILE) );
ok( Test::Builder->is_fh(\*FILE) );
ok( Test::Builder->is_fh(*FILE{IO}) );

tie *OUT, 'TieOut';
ok( Test::Builder->is_fh(*OUT) );
ok( Test::Builder->is_fh(\*OUT) );

SKIP: {
    skip "*TIED_HANDLE{IO} doesn't work in this perl", 1
        unless defined *OUT{IO};
    ok( Test::Builder->is_fh(*OUT{IO}) );
}


package Lying::isa;

sub isa {
    my $self = shift;
    my $parent = shift;
    
    return 1 if $parent eq 'IO::Handle';
}

::ok( Test::Builder->is_fh(bless {}, "Lying::isa"));
