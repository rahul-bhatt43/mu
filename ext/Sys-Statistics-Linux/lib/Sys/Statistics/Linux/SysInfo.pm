#!/usr/bin/pugs

=begin pod

=head1 NAME

Sys::Statistics::Linux::SysInfo - Collect linux system informations.

=head1 SYNOPSIS

   use Sys::Statistics::Linux::SysInfo;

   my $lxs   = Sys::Statistics::Linux::SysInfo.new;
   my %stats = $lxs.get;

=head1 DESCRIPTION

Sys::Statistics::Linux::SysInfo gathers system informations from the virtual F</proc> filesystem (procfs).

For more informations read the documentation of the front-end module L<Sys::Statistics::Linux>.

=head1 SYSTEM INFOMATIONS

Generated by F</proc/sys/kernel/{hostname,domainname,ostype,osrelease,version}>
and F</proc/cpuinfo>, F</proc/meminfo>, F</proc/uptime>.

   hostname   -  This is the host name.
   domain     -  This is the host domain name.
   kernel     -  This is the kernel name.
   release    -  This is the release number.
   version    -  This is the version number.
   memtotal   -  The total size of memory.
   swaptotal  -  The total size of swap space.
   countcpus  -  The total (maybe logical) number of CPUs.
   uptime     -  This is the uptime of the system.
   idletime   -  This is the idle time of the system.

=head1 METHODS

=head2 new()

Call C<new()> to create a new object.

   my $lxs = Sys::Statistics::Linux::SysInfo.new;

=head2 get()

Call C<get()> to get the statistics. C<get()> returns the statistics as a hash reference.

   my %stats = $lxs.get;

=head1 EXAMPLES

    my $lxs = Sys::Statistics::Linux::SysInfo.new;
    my %stats = $lxs.get;

    for <hostname domain kernel release version memtotal swaptotal countcpus uptime idletime> -> $x {
        printf "%-12s%s\n", $x, %stats{$x};
    }

=head1 EXPORTS

No exports.

=head1 SEE ALSO

B<proc(5)>

=head1 REPORTING BUGS

Please report all bugs to <jschulz.cpan(at)bloonix.de>.

=head1 AUTHOR

Jonny Schulz <jschulz.cpan(at)bloonix.de>.

=head1 COPYRIGHT

Copyright (c) 2006, 2007 by Jonny Schulz. All rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=end pod

#package Sys::Statistics::Linux::SysInfo;
#our $VERSION = '0.04';

class Sys::Statistics::Linux::SysInfo-0.001;

use v6-alpha;

#use strict;
#use warnings;
#use Carp qw(croak);

sub croak (*@m) { die @m } # waiting for Carp::croak

#sub new {
#   my $class = shift;
#   my %self = (
#      files => {
#         meminfo    => '/proc/meminfo',
#         sysinfo    => '/proc/sysinfo',
#         cpuinfo    => '/proc/cpuinfo',
#         uptime     => '/proc/uptime',
#         hostname   => '/proc/sys/kernel/hostname',
#         domain     => '/proc/sys/kernel/domainname',
#         kernel     => '/proc/sys/kernel/ostype',
#         release    => '/proc/sys/kernel/osrelease',
#         version    => '/proc/sys/kernel/version',
#         #sem        => '/proc/sys/kernel/sem',
#         #shmall     => '/proc/sys/kernel/shmall',
#         #shmmax     => '/proc/sys/kernel/shmmax',
#         #shmmni     => '/proc/sys/kernel/shmmni',
#      }
#   );
#   return bless \%self, $class;
#}

has %.files;

submethod BUILD () {
    $.files<meminfo>  = '/proc/meminfo';
    $.files<sysinfo>  = '/proc/sysinfo';
    $.files<cpuinfo>  = '/proc/cpuinfo';
    $.files<uptime>   = '/proc/uptime';
    $.files<hostname> = '/proc/sys/kernel/hostname';
    $.files<domain>   = '/proc/sys/kernel/domainname';
    $.files<kernel>   = '/proc/sys/kernel/ostype';
    $.files<release>  = '/proc/sys/kernel/osrelease';
    $.files<version>  = '/proc/sys/kernel/version';
    #$.files<sem>      = '/proc/sys/kernel/sem';
    #$.files<shmall>   = '/proc/sys/kernel/shmall';
    #$.files<shmmax>   = '/proc/sys/kernel/shmmax';
    #$.files<shmmni>   = '/proc/sys/kernel/shmmni';
}

#sub get {
#   my $self = shift;
#   my $class = ref $self;
#   my $file  = $self->{files};
#   my $stats = $self->{stats};
#
#   #for my $x (qw(hostname domain kernel release version shmmax shmall shmmni)) {
#   for my $x (qw(hostname domain kernel release version)) {
#      open my $fh, '<', $file->{$x} or croak "$class: unable to open $file->{$x} ($!)";
#      $stats->{$x} = <$fh>;
#      close($fh);
#   }
#
#   #{  # read sem info
#   #   open my $fh, '<', $file->{sem} or croak "$class: unable to open $file->{sem} ($!)";
#   #   @{$stats}{qw/semmsl semmns semopm semmni/} = split /\s+/, <$fh>;
#   #   close $fh;
#   #}
#
#   {  # memory and swap info
#      open my $fh, '<', $file->{meminfo} or croak "$class: unable to open $file->{meminfo} ($!)";
#
#      while (my $line = <$fh>) {
#         if ($line =~ /^MemTotal:\s+(\d+ \w+)/) {
#            $stats->{memtotal} = $1;
#         } elsif ($line =~ /^SwapTotal:\s+(\d+ \w+)/) {
#            $stats->{swaptotal} = $1;
#         }
#      }
#
#      close($fh);
#   }
#
#   {  # cpu info
#      $stats->{countcpus} = 0;
#
#      open my $fh, '<', $file->{cpuinfo} or croak "$class: unable to open $file->{cpuinfo} ($!)";
#
#      while (my $line = <$fh>) {
#         if ($line =~ /^processor\s*:\s*\d+/) {            # x86
#            $stats->{countcpus}++;
#         } elsif ($line =~ /^# processors\s*:\s*(\d+)/) {  # s390
#            $stats->{countcpus} = $1;
#            last;
#         }
#      }
#
#      close($fh);
#   }
#
#   {  # up- and idletime
#      open my $fh, '<', $file->{uptime} or croak "$class: unable to open $file->{uptime} ($!)";
#
#      foreach my $x (split /\s+/, <$fh>) {
#         my ($d, $h, $m, $s) = $self->_calsec(sprintf('%li', $x));
#
#         unless (defined $stats->{uptime}) {
#            $stats->{uptime} = "${d}d ${h}h ${m}m ${s}s";
#            next;
#         }
#
#         $stats->{idletime} = "${d}d ${h}h ${m}m ${s}s";
#      }
#
#      close($fh);
#   }
#
#   foreach my $key (keys %{$stats}) {
#      chomp $stats->{$key};
#      $stats->{$key} =~ s/\t+/ /g;
#      $stats->{$key} =~ s/\s+/ /g;
#   }
#
#   return $stats;
#}

method get () {
    my %files = self.files;
    my %stats;

    for <hostname domain kernel release version> -> $x {
        #my $fh = open(%files{$x}, :r) or croak("unable to open %file{$x}: $!");
        my $fh = %files{$x};
        #%stats{$x} = =$fh;
        #$fh.close;
        # this is just a work around because it doesnt work with open correct
        for =$fh -> $line { %stats{$x} = $line }
    }

    # memory and swap info
    my $memfh = open(%files<meminfo>, :r) or croak("unable to open %files<meminfo>: $!");

    for =$memfh -> $line {
        if $line ~~ /^MemTotal\:\s+(\d+\s\w+)/ {
            %stats<memtotal> = $0;
        } elsif $line ~~ /^SwapTotal\:\s+(\d+\s\w+)/ {
            %stats<swaptotal> = $0;
        }
    }

    $memfh.close;

    # cpu info
    %stats<countcpus> = 0;

    my $cpufh = open(%files<cpuinfo>, :r) or croak("unable to open %files<cpuinfo>: $!");

    for =$cpufh -> $line {
        if $line ~~ /^processor\s*\:\s*\d+/ {            # x86
            %stats<countcpus>++;
        } elsif $line ~~ /^\#\sprocessors\s*\:\s*(\d+)/ {  # s390
            %stats<countcpus> = $0;
            last;
        }
    }

    $cpufh.close;

    # up- and idletime
    my $upfh = open(%files<uptime>, :r) or croak("unable to open %files<uptime>: $!");

    for $upfh.readline.comb -> $x {
        my ($d, $h, $m, $s) = self.calsec($x);

        unless %stats<uptime>.defined {
            %stats<uptime> = "{$d}d {$h}h {$m}m {$s}s";
            next;
        }

        %stats<idletime> = "{$d}d {$h}h {$m}m {$s}s";
    }

    for %stats.keys -> $key {
        %stats{$key}.chomp;
        %stats{$key} ~~ s/\t+/ /;
        %stats{$key} ~~ s/\s+/ /;
    }

    return %stats;
}

#sub _calsec {
#   my $self = shift;
#   my ($s, $m, $h, $d) = (shift, 0, 0, 0);
#   $s >= 86400 and $d = sprintf('%i',$s / 86400) and $s = $s % 86400;
#   $s >= 3600  and $h = sprintf('%i',$s / 3600)  and $s = $s % 3600;
#   $s >= 60    and $m = sprintf('%i',$s / 60)    and $s = $s % 60;
#   return ($d, $h, $m, $s);
#}

my method calsec ($s is copy) {
    my ($m, $h, $d) = (0, 0, 0);
    $s >= 86400 and $d = sprintf('%d', $s / 86400) and $s = $s % 86400;
    $s >= 3600  and $h = sprintf('%d', $s / 3600)  and $s = $s % 3600;
    $s >= 60    and $m = sprintf('%d', $s / 60)    and $s = $s % 60;
    $s = sprintf('%d', $s);
    return ($d, $h, $m, $s);
}

1;
