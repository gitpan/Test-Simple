#!perl -w
# $Id: /mirror/googlecode/test-more/t/reset_outputs.t 60308 2008-09-07T22:36:18.175234Z schwern  $

BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't';
        @INC = ('../lib', 'lib');
    }
    else {
        unshift @INC, 't/lib';
    }
}

use Test::Builder;
use Test::More 'no_plan';

{
    my $tb = Test::Builder->create();

    # Store the original output filehandles and change them all.
    my %original_outputs;

    open my $fh, ">", "dummy_file.tmp";
    END { 1 while unlink "dummy_file.tmp"; }
    for my $method (qw(output failure_output todo_output)) {
        $original_outputs{$method} = $tb->$method();
        $tb->$method($fh);
        is $tb->$method(), $fh;
    }

    $tb->reset_outputs;

    for my $method (qw(output failure_output todo_output)) {
        is $tb->$method(), $original_outputs{$method}, "reset_outputs() resets $method";
    }
}
