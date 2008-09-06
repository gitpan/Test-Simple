#!/usr/bin/perl
# $Id: /mirror/googlecode/test-more/t/tbt_04line_num.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

use Test::More tests => 3;
use Test::Builder::Tester;

is(line_num(),7,"normal line num");
is(line_num(-1),7,"line number minus one");
is(line_num(+2),11,"line number plus two");
