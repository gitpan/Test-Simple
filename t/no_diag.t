#!/usr/bin/perl -w
# $Id: /mirror/googlecode/test-more/t/no_diag.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

use Test::More 'no_diag', tests => 2;

pass('foo');
diag('This should not be displayed');

is(Test::More->builder->no_diag, 1);
