#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::V1::Cron;
use Mojo::Base 'Mojolicious::Controller';
use Rex::Server::Helper::Rex;

sub add {
   my $self = shift;
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "add", $self->param("user");

   my $ret = Rex::Server::Helper::Rex->run_command("cron", $options);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub list {
   my $self = shift;
   
   my $json = $self->req->json;

   unshift @{ $json->{args} }, "list", $self->param("user");
   my @ret = Rex::Server::Helper::Rex->run_command("cron", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => \@ret});
}

sub delete {
   my $self = shift;

   my $json = $self->req->json;
   unshift @{ $json->{args} }, "add", $self->param("user"), $self->param("id");

   my $ret = Rex::Server::Helper::Rex->run_command("cron", $json);
}

1;
