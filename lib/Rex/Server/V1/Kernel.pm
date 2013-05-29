#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::V1::Kernel;
use Mojo::Base 'Mojolicious::Controller';
use Rex::Server::Helper::Rex;

sub load {
   my $self = shift;
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "load";
   my $ret = Rex::Server::Helper::Rex->run_command("kmod", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub unload {
   my $self = shift;
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "unload";
   my $ret = Rex::Server::Helper::Rex->run_command("kmod", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

1;
