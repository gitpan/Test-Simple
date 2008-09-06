#!/usr/bin/perl -w
# $Id: /mirror/googlecode/test-more/t/curr_test.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

# Dave Rolsky found a bug where if current_test() is used and no
# tests are run via Test::Builder it will blow up.

use Test::Builder;
$TB = Test::Builder->new;
$TB->plan(tests => 2);
print "ok 1\n";
print "ok 2\n";
$TB->current_test(2);
