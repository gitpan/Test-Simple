require Test::Simple;

push @INC, 't', '.';
require Catch;
my($out, $err) = Catch::caught();

Test::Simple->import(tests => 5);


ok(1);
ok(2);
ok(0);
ok(1);
ok(2);