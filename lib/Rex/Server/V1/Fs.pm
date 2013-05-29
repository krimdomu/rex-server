#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Server::V1::Fs;
use Mojo::Base 'Mojolicious::Controller';
use Rex::Server::Helper::Rex;

use MIME::Base64;

my $command_map = {
   mkdir          => "mkdir",
   rmdir          => "rmdir",
   cp             => "cp",
   rm             => "rm",
   mv             => "mv",
   unlink         => "unlink",
   stat           => "stat",
   readlink       => "readlink",
   symlink        => "symlink",
   rename         => "rename",
   is_file        => "is_file",
   is_dir         => "is_dir",
   is_writable    => "is_writable",
   is_readable    => "is_readable",
   chown          => "chown",
   chmod          => "chmod",
   chgrp          => "chgrp",
};

sub run {
   my $self = shift;
   my $json = $self->req->json;

   if(exists $command_map->{$self->param("command")}) {
      my $ret = Rex::Server::Helper::Rex->run_command($command_map->{$self->param("command")}, $json);
      return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
   }
   else {
      return $self->render(json => {ok => Mojo::JSON->false}, status => 404);
   }
}

sub download {
   my $self = shift;
   my $json = $self->req->json;

   my $file = "/tmp/random-file.rnd";
   Rex::Server::Helper::Rex->run_command("download", $json->{src}, $file);

   my $content = encode_base64(eval { local(@ARGV, $/) = ($file); <>; });

   unlink $file; # remove temp file

   return $self->render(json => {ok => Mojo::JSON->true, return => $content});
}

sub upload {
   my $self = shift;
   my $json = $self->req->json;

   my $file = "/tmp/random-file.rnd";
   open(my $fh, ">", $file) or die($!);
   print $fh $json->{content};
   close($fh);

   my $ret = Rex::Server::Helper::Rex->run_command("upload", $file, $json->{dst});

   unlink $file; # remove temp file

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

sub md5 {
   my $self = shift;
   my $json = $self->req->json;

   my $ret = Rex::Server::Helper::Rex->run_command("md5", $json);

   return $self->render(json => {ok => Mojo::JSON->true, return => $ret});
}

1;
