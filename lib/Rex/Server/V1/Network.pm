#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::V1::Network;
use Mojo::Base 'Mojolicious::Controller';
use Rex::Server::Helper::Rex;

sub route {
   my $self = shift;
   my $json = $self->req->json;

   my @ret = Rex::Server::Helper::Rex->run_command("route", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => \@ret});
}

sub default_gateway {
   my $self = shift;
   my $json = $self->req->json;

   my $ret = Rex::Server::Helper::Rex->run_command("default_gateway", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub netstat {
   my $self = shift;
   my $json = $self->req->json;

   my @ret = Rex::Server::Helper::Rex->run_command("netstat", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => \@ret});
}

1;
