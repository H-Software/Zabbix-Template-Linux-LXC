#!/usr/bin/perl

# Patrik Majer (patrik.majer.pisek@gmail.com)
#
# Zabbix 2 - LXC containers handler for linux
#
# all parameters listed in /sys/fs/cgroup/lxc/ are returned
#

my $mode = $ARGV[0];
my $name = $ARGV[1];

if($mode eq "PID"){

     if( $name =~ /^([a-z]|[A-Z]|[0-9]|_|-|\.)+$/ ){
        $result = `lxc-info -n $name 2>&1`;
        if ($result =~ m/pid:([[:space:]]*)((-|[0-9])+)/){
            print "$2\n";
            exit 0;
        }
        else{
            print STDERR "ERROR! Wront results (PID)\n";
            print STDERR "DEBUG: ".$result."\n";
            exit 33;
        }
     }
     else{
        print STDERR "ERROR! Wrong input \"name\" (PID)\n";
        exit 2;
    }

}
elsif($mode eq "STATE"){

     if( $name =~ /^([a-z]|[A-Z]|[0-9]|_|-|\.)+$/ ){
        $result = `lxc-info -n $name 2>&1`;
        if ($result =~ m/state:([[:space:]]*)([A-Z]+)/){
            print "$2\n";
            exit 0;
        }
        else{
            print STDERR "ERROR! Wront results (STATE)\n";
            print STDERR "DEBUG: ".$result."\n";
            exit 33;
        }
     }
     else{
        print STDERR "ERROR! Wrong input \"name\" (STATE)\n";
        exit 2;
    }

}
elsif($mode eq "NEXT"){

}
else{

 print STDERR "ERROR! Unknown mode\n";

 exit 1;

}

