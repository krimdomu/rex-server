#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::V1::Pkg;
use Mojo::Base 'Mojolicious::Controller';
use Rex::Server::Helper::Rex;

sub install {
   my $self = shift;
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "package";
   my $ret = Rex::Server::Helper::Rex->run_command("install", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub remove {
   my $self = shift;
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "package";
   my $ret = Rex::Server::Helper::Rex->run_command("remove", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub update_system {
   my $self = shift;
   my $json = $self->req->json;

   my $ret = Rex::Server::Helper::Rex->run_command("update_system", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub update_package_db {
   my $self = shift;
   my $json = $self->req->json;

   my $ret = Rex::Server::Helper::Rex->run_command("update_package_db", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub installed_packages {
   my $self = shift;
   my $json = $self->req->json;

   my @ret = Rex::Server::Helper::Rex->run_command("installed_packages", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => \@ret});
}

sub repository_add {
   my $self = shift;
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "add", $self->param("name");
   my $ret = Rex::Server::Helper::Rex->run_command("repository", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});

}

sub repository_delete {
   my $self = shift;
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "remove", $self->param("name");
   my $ret = Rex::Server::Helper::Rex->run_command("repository", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

1;
