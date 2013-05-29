#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
=head1 NAME

Rex::Server::Root

=head1 DESCRIPTION

Basic URLs for common API information.

=head1 CALLS

=over 4

=item GET /

Display common information of URLs.

=back

=cut

package Rex::Server::Root;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub info {
   my $self = shift;

   my $info = {
      routes => {
         '/api/1.0/version' => 'Display the version of the API.',
         '/api/1.0/run'     => 'Runs a command on a remote host and return the output and the return value.',
      }
   };

   $self->render_json({ok => Mojo::JSON->true, return => $info});
}

1;
