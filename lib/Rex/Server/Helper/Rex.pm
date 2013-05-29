#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::Helper::Rex;

use strict;
use warnings;


use Rex -feature => '0.42';
use Rex::Transaction;
use Rex::Commands::Cron;
use Rex::Commands::Kernel;


my $cached_connections = {};

=over 4

=item run_command($command, $options)

 run_command( "foo", {
    args    => [$first, $second, ...],
    server  => "servername",
    user     => "user",
    password => "password",
    private_key => "/path/to/private/key",
    public_key  => "/path/to/public/key",
 });

=cut

sub run_command {
   my ($class, $command, $options) = @_;

no strict 'refs';
   # don't fork
   Rex::TaskList->create()->set_in_transaction(1);
   if(exists $cached_connections->{$options->{server} . "-" . $options->{user}}) {
      Rex::connect(
         cached_connection => $cached_connections->{$options->{server} . "-" . $options->{user}},
      );
   } 
   else {
      my $conn = Rex::connect(
         server      => $options->{server},
         user        => $options->{user}           || "",
         password    => $options->{password}       || "",
         private_key => $options->{private_key}    || "",
         public_key  => $options->{public_key}     || "",
      );

      $cached_connections->{$options->{server} . "-" . $options->{user}} = $conn;
   }
   
   return &$command(@{ $options->{args} });
}

1;
