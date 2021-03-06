package Web::Terminal::Server;

use vars qw( $VERSION );
$VERSION = '0.2.0';
use utf8;
use strict;

use YAML::Syck;
#use lib '.';

use Proc::Daemon;
use lib '.','../..'; #�to keep EPIC happy
use Web::Terminal::Settings;
use Web::Terminal::Msg;
use Web::Terminal::Server::Session;

our @ISA         = qw( Exporter );
our @EXPORT   = qw( run );
our @EXPORT_OK   = qw( run );
our %EXPORT_TAGS = (
        ALL     => [qw( run )],
        DEFAULT => [],
        );

#$|=1;
$SIG{CHLD} = 'IGNORE';

# The messages contain the session id.
# If the ID does not exist in %terminals, create a new session
# Otherwise, write to the terminal and send back the result, again
# with the session id as first line.

our %terminals=();
our %nsessions_per_ip=();

my $v=1-$Web::Terminal::Settings::daemon;

sub termhandler {
	my $id  = shift;
    my $ip=shift;
    my $app=shift;
    my $ia=shift;
	my $cmd = shift;
if(scalar(keys %terminals)>$Web::Terminal::Settings::nsessions){ # each pugs takes 1% of feather's MEM!
    print "Sorry, I can't run any more sessions.\nPlease try again later.\n"
    if $v;
    return "Sorry, I can't run any more sessions.\nPlease try again later.";
} else {
	if ( exists $terminals{$id} ) {
    print "Connecting to session $id\n" if $v;
    if ($terminals{$id}->{pid}) {    
    $terminals{$id}->{called}=time;
        #if swap to other app #PRE: This will result in a new create()
        if ($app != $terminals{$id}->{'app'}) {
                 &killterm($id);
	        	$terminals{$id} = new
                Web::Terminal::Server::Session(app=>$app,ia=>$ia,id=>$id,cmds=>$cmd);
        		my $term = $terminals{$id};
	            $term->{called}=time;
                my $output= $term->{'output'};
                my $error= $term->{'error'};
                if ($error==1) { # Failed to create a new terminal
                $nsessions_per_ip{$ip}--;
                &killterm($id);
                } 
    	    	return $output;
        }
		my $term  = $terminals{$id};
        push  @{$term->{recent}},$cmd unless $cmd=~/^\s*$/;
        if (scalar @{$term->{recent}}> $Web::Terminal::Settings::nrecent) {
            shift @{$term->{recent}};
        }
		my $lines = $term->write($cmd);
		if ( $cmd eq $Web::Terminal::Settings::quit_command ) {
            &killterm($id);
            $nsessions_per_ip{$ip}--;
            return $lines;
        } elsif ($terminals{$id}->{error}==1) {
            &killterm($id);
            $nsessions_per_ip{$ip}--;
        }
		return $lines;
        } else {
            return $Web::Terminal::Settings::prompt;
        }
	} else {
        if ($nsessions_per_ip{$ip}>$Web::Terminal::Settings::nsessions_ip) {
        print LOG2 "MAX nsessions for $ip reached\n";
        print "MAX nsessions for $ip reached\n" if $v;
         return "Sorry, you can't run more than ${Web::Terminal::Settings::nsessions_ip} sessions from one IP address.\n";   
        } else {
        print "New $id\n" if $v;
            $nsessions_per_ip{$ip}++;
            print "$app $ia $id $cmd\n" if $v;
    		$terminals{$id} = new
            Web::Terminal::Server::Session(app=>$app,ia=>$ia,id=>$id,cmds=>$cmd);
            $terminals{$id}->{called}=time;
            $terminals{$id}->{ip}=$ip;
    		my $term = $terminals{$id};
            my $output= $term->{'output'};
            my $error= $term->{'error'};
            if ($error==1 or $ia==0) { # Failed to create a new terminal
            print " Failed to create a new terminal: <$output> err:$error ia:$ia\n" if $v;
                $nsessions_per_ip{$ip}--;
                &killterm($id);
            }
            return $output;
        }
	}
}
} # of termhandler

sub rcvd_msg_from_client {
	my ( $conn, $msg, $err ) = @_;
	if ( defined $msg ) {
		my $len = length($msg);
		if ( $len > 0 ) {
#			( my $id, my $ip, my $cmd ) = split( "\n", $msg, 3 );
			my $mesgref=YAML::Syck::Load($msg);
			my $id=$mesgref->{id};
            my $ip=$mesgref->{ip};
            my $cmd=$mesgref->{cmd};
            my $app=$mesgref->{app};
            my $ia=$mesgref->{ia};
#            $cmd=pack("U0C*", unpack("C*",$cmd));
            my $pid=0;
            my $nsess=scalar keys %terminals;
            if(exists $terminals{$id}) {
                $pid=$terminals{$id}->{pid};
            print LOG2 scalar(localtime)," : $nsess : $ip : $id : $pid > ",$cmd,"\n";
            print scalar(localtime)," : $nsess : $ip : $id : $pid >
            ",$cmd,"\n" if $v;
            } else {
            print LOG2 scalar(localtime)," : $nsess : $ip : $id : NO PID! > ",$cmd,"\n";
            print scalar(localtime)," : $nsess : $ip : $id : NO PID! >
            ",$cmd,"\n" if $v;
            }
            #print scalar(localtime)," : $nsess : $ip : $id : $pid > ",$cmd,"\n";
#            print LOG2 scalar(localtime)," : $nsess : $ip : $id : $pid > ",$cmd,"\n";
			my $lines = &termhandler( $id, $ip, $app,$ia, $cmd );
            my @history=(''); #   --- Recent commands ---');
            my $prompt=$Web::Terminal::Settings::prompt;
            if (exists $terminals{$id}){ 
                $prompt=$terminals{$id}->{prompt};
            if (defined $terminals{$id}->{recent}) {
             @history=@{$terminals{$id}->{recent}};
            }
            }
            my
            $replyref=YAML::Syck::Dump({id=>$id,msg=>$lines,recent=>\@history,prompt=>$prompt});
 			$conn->send_now($replyref);

		}
	}
}

sub login_proc {
	# Unconditionally accept
	\&rcvd_msg_from_client;
}

sub run {
my $host=$Web::Terminal::Settings::host;#shift;
my $port=$Web::Terminal::Settings::port;#shift;

$SIG{USR1}=\&timeout;
if ( $Web::Terminal::Settings::daemon) {
    Proc::Daemon::Init;
}
# fork/exec by the book:
use Errno qw(EAGAIN);
my $pid;
FORK: {
if ($pid=fork) {
    #parent here
    if (-e
    "$Web::Terminal::Settings::log_path/$Web::Terminal::Settings::appname.log") {
        rename
        "$Web::Terminal::Settings::log_path/$Web::Terminal::Settings::appname.log",
        "$Web::Terminal::Settings::log_path/$Web::Terminal::Settings::appname.log.".join("",localtime);
    }
    open(LOG2,">$Web::Terminal::Settings::log_path/$Web::Terminal::Settings::appname.log");
    #select LOG2; $|=1;
    print "Parent: create new server..." if $v;
    Web::Terminal::Msg->new_server( $host, $port, \&login_proc );
    print "OK\n" if $v;
    Web::Terminal::Msg->event_loop();
} elsif (defined $pid) {
   # child here
   while (getppid()>10) { # a bit ad-hoc.
       sleep $Web::Terminal::Settings::check_interval;
        print "Child: ",getppid(),"\n" if $v;
        kill 'USR1',getppid();
    }
    #system("killall $Web::Terminal::Settings::commands[$app]");
    chdir $Web::Terminal::Settings::cgi_path;
    exec("$Web::Terminal::Settings::perl ../bin/$Web::Terminal::Settings::server");
#    chdir "/home/andara/apache/cgi-bin/";
#    exec('/usr/bin/perl ../bin/termserv.pl');
} elsif ($! == EAGAIN) {
    sleep 5;
    redo FORK;
} else {
    print "Couldn't fork" if $v;
    die "Can't fork: $!\n";
} 
} # FORK
}

sub timeout() {
    my $now=time();
    for my $id (keys %terminals) {
        if(exists $terminals{$id}) {
        my $then=$terminals{$id}->{called};
        if ($now-$then>$Web::Terminal::Settings::timeout_idle) {
          my $pid= $terminals{$id}->{pid};
            my $ip=$terminals{$id}->{ip};
            $nsessions_per_ip{$ip}--;
#             if ($pid) {
#                kill 9,$pid;
#            }
#            $terminals{$id}->write(':q');
            &killterm($id);
            print LOG2 "Cleaned up $ip : $id : $pid\n";
            print "Cleaned up $ip : $id : $pid\n" if $v;
            }
        }
    }
}
sub killterm {
    my $id=shift;
#    my $pid= $terminals{$id}->{pid};
    # WHY?!
    $terminals{$id}->DESTROY();
    delete $terminals{$id};
#    if ($pid) {
#        kill 9,$pid;
#    }
}

1;

__END__

=head1 NAME

Web::Terminal::Server -- Server for Web::Terminal
Requires YAML::Syck, Proc::Daemon.

=head1 SYNOPSIS

    use Web::Terminal::Server;
    use  Web::Terminal::Settings;
    &Web::Terminal::Server::run();

=head1 DESCRIPTION

This module exports a single subroutine C<run>, which runs the Web::Terminal
server. See L<Settings> for configuration options.

=head1 SEE ALSO

L<Web::Terminal::Settings>,
L<Web::Terminal::Dispatcher>,
L<Web::Terminal::Server::Session>,
L<Web::Terminal::Msg>

=head1 AUTHOR

Wim Vanderbauwhede <wim.vanderbauwhede@gmail.com>

=head1 COPYRIGHT

Copyright (c) 2006. Wim Vanderbauwhede. All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
