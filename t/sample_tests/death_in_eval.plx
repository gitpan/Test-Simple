require Test::Simple;
use Carp;

push @INC, 't', '.';
require Catch;
my($out, $err) = Catch::caught();

Test::Simple->import(tests => 5);

ok(1);
ok(1);
ok(1);
eval {
        die "Foo";
};
ok(1);
eval "die 'Bar'";
ok(1);

eval {
        croak "Moo";
};
