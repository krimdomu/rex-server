#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   

package Rex::Server::V1::Api;
use Mojo::Base 'Mojolicious::Controller';

our $VERSION = '1.0';

# This action will render a template
sub version {
   my $self = shift;
   $self->render(json => {ok => Mojo::JSON->true, return => $VERSION});
}

1;
