#!/usr/bin/perl
# $Id: /mirror/googlecode/test-more/t/tbt_03die.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

use Test::Builder::Tester tests => 1;
use Test::More;

eval {
    test_test("foo");
};
like($@,
     "/Not testing\.  You must declare output with a test function first\./",
     "dies correctly on error");

