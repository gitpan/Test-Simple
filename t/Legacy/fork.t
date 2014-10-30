#!/usr/bin/perl -w

BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't';
        @INC = '../lib';
    }
}

use Test::More;
use Config;

my $Can_Fork = $Config{d_fork} ||
               (($^O eq 'MSWin32' || $^O eq 'NetWare') and
                $Config{useithreads} and
                $Config{ccflags} =~ /-DPERL_IMPLICIT_SYS/
               );

if( !$Can_Fork ) {
    plan skip_all => "This system cannot fork";
}
elsif ($^O eq 'MSWin32' && $] == 5.010000) {
    plan 'skip_all' => "5.10 has fork/threading issues that break fork on win32";
}
else {
    plan tests => 1;
}

my $pid = fork;
if( $pid ) { # parent
    pass("Only the parent should process the ending, not the child");
    waitpid($pid, 0);
}
else {
    exit;   # child
}

