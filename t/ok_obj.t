#!/usr/bin/perl -w
# $Id: /mirror/googlecode/test-more/t/ok_obj.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

# Testing to make sure Test::Builder doesn't accidentally store objects
# passed in as test arguments.

BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't';
        @INC = '../lib';
    }
}

use Test::More tests => 4;

package Foo;
my $destroyed = 0;
sub new { bless {}, shift }

sub DESTROY {
    $destroyed++;
}

package main;

for (1..3) {
    ok(my $foo = Foo->new, 'created Foo object');
}
is $destroyed, 3, "DESTROY called 3 times";

