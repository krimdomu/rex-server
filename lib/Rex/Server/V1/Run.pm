#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::V1::Run;
use Mojo::Base 'Mojolicious::Controller';
use Rex::Server::Helper::Rex;

sub run {
   my $self = shift;
   my $json = $self->req->json;

   my @stdout = Rex::Server::Helper::Rex->run_command("run", $json);
   my $retval = $?;

   $self->render(json => {ok => Mojo::JSON->true, return => {
      stdout => \@stdout,
      retval => $retval,
   }});
}

1;
