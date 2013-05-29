package Rex::Server;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
   my $self = shift;

   # Router
   my $r = $self->routes;

   # Normal route to controller
   $r->get("/")->to("root#info");

   # API calls
   $r->get("/api/1.0/version")->to("v1-api#version");
   $r->post("/api/1.0/run")->to("v1-run#run");

   $r->post("/api/1.0/fs/:command")->to("v1-fs#run");
}

1;
