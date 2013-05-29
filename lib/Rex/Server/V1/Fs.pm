#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::V1::Fs;
use Mojo::Base 'Mojolicious::Controller';
use Rex::Server::Helper::Rex;

my $command_map = {
   mkdir => "mkdir",
   rmdir => "rmdir",
   cp    => "cp",
   rm    => "rm",
   mv    => "mv",
};

sub run {
   my $self = shift;
   my $json = $self->req->json;

   if(exists $command_map->{$self->param("command")}) {
      my $ret = Rex::Server::Helper::Rex->run_command($self->param("command"), $json);
      return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
   }
   else {
      return $self->render(json => {ok => Mojo::JSON->false}, status => 404);
   }
}

1
