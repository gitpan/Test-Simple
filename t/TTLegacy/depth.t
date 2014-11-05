use strict;
use warnings;

BEGIN {
    if ($ENV{PERL_CORE}) {
        chdir 't';
        @INC = ('../lib', 'lib');
    }
    else {
        unshift @INC, 't/lib';
    }
}

use Test::Tester;

use MyTest;

my $test = Test::Builder->new;
$test->plan(tests => 2);

sub deeper
{
    local $Test::Builder::Level = $Test::Builder::Level + 1;
	MyTest::ok(1);
}

{

	my @results = run_tests(
		sub {
			MyTest::ok(1);
			deeper();
		}
	);

	local $Test::Builder::Level = 0;
	$test->is_num($results[1]->{depth}, 1, "depth 1");
	$test->is_num($results[2]->{depth}, 2, "deeper");
}

