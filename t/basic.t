use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Karabas');
$t->get_ok('/auth')->status_is(200)->content_like(qr/<html>/i);

done_testing();
