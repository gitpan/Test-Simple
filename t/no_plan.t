#!/usr/bin/perl -w
# $Id: /mirror/googlecode/test-more/t/no_plan.t 60319 2008-09-08T21:16:57.125001Z schwern  $

BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't';
        @INC = ('../lib', 'lib');
    }
    else {
        unshift @INC, 't/lib';
    }
}

use Test::More tests => 9;

my $tb = Test::Builder->create;
$tb->level(0);

#line 19
ok !eval { $tb->plan(tests => undef) };
is($@, "Got an undefined number of tests at $0 line 19.\n");

#line 23
ok !eval { $tb->plan(tests => 0) };
is($@, "You said to run 0 tests at $0 line 23.\n");

#line 28
ok !eval { $tb->ok(1) };
is( $@, "You tried to run a test without a plan at $0 line 28.\n");

{
    my $warning = '';
    local $SIG{__WARN__} = sub { $warning .= join '', @_ };

#line 36
    ok $tb->plan(no_plan => 1);
    is( $warning, "no_plan takes no arguments at $0 line 36.\n" );
    is $tb->has_plan, 'no_plan';
}
