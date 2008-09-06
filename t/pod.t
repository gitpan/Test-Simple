#!/usr/bin/perl -w
# $Id: /mirror/googlecode/test-more/t/pod.t 57943 2008-08-18T02:09:22.275428Z brooklyn.kid51  $

use Test::More;
eval "use Test::Pod 1.00";
plan skip_all => "Test::Pod 1.00 required for testing POD" if $@;
all_pod_files_ok();
