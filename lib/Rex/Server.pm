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

   # run command
   $r->post("/api/1.0/run")->to("v1-run#run");

   # Filesystem operations
   $r->post("/api/1.0/fs/:command")->to("v1-fs#run");
   $r->post("/api/1.0/fs/download")->to("v1-fs#download");
   $r->post("/api/1.0/fs/upload")->to("v1-fs#upload");
   $r->post("/api/1.0/fs/md5")->to("v1-fs#md5");

   # cron
   $r->post("/api/1.0/cron/add/:user")->to("v1-cron#add");
   $r->post("/api/1.0/cron/list/:user")->to("v1-cron#list");
   $r->post("/api/1.0/cron/delete/:user/:id")->to("v1-cron#delete");

   # kernel
   $r->post("/api/1.0/kernel/load/:module")->to("v1-kernel#load");
   $r->post("/api/1.0/kernel/unload/:module")->to("v1-kernel#unload");

   # network
   $r->post("/api/1.0/network/route")->to("v1-network#route");
   $r->post("/api/1.0/network/default_gateway")->to("v1-network#default_gateway");
   $r->post("/api/1.0/network/netstat")->to("v1-network#netstat");

   # packages
   $r->post("/api/1.0/package/install/:package")->to("v1-pkg#install");
   $r->post("/api/1.0/package/remove/:package")->to("v1-pkg#remove");
   $r->post("/api/1.0/package/update_system")->to("v1-pkg#update_system");
   $r->post("/api/1.0/package/update_package_db")->to("v1-pkg#update_package_db");
   $r->post("/api/1.0/package/installed")->to("v1-pkg#installed_packages");
   $r->post("/api/1.0/package/repository/add/:name")->to("v1-pkg#repository_add");
   $r->post("/api/1.0/package/repository/delete/:name")->to("v1-pkg#repository_delete");
}


1;
