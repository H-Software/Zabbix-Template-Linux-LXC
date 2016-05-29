#!/usr/bin/perl

# Patrik Majer (patrik.majer.pisek@gmail.com)
#
# Zabbix 2 - LXC containers handler for linux
#
# all parameters listed in /sys/fs/cgroup/lxc/ are returned
#

my $mode = $ARGV[0];
my $name = $ARGV[1];

#
#check input variable
#
unless( $name =~ /^([a-z]|[A-Z]|[0-9]|_|-|\.)+$/ ){
        print STDERR "ERROR! Wrong input \"name\"\n";
        exit 2;
}

#
#internal rutines
#
sub print_error {
    foreach $msq (@_){
        print STDERR $msq;
    }

    print STDERR " (". $mode .")\n";
    exit 2;
}

sub print_result {
    foreach $msq (@_){
        print $msq;
    }

    print "\n";
    exit 0;
}

#
# check OS
#
@result = `ls /sys/fs/cgroup/lxc > /dev/null 2>&1`;

if ( $? == -1 ){
  #print "command failed: $!\n";
}
else {
  # printf "command exited with value %d", $? >> 8;

  if ( $? == 0 ){
    #debian
    our $workdir="/sys/fs/cgroup/lxc";
  }
  else {
    # centos or another OS
    if( $mode =~ /CPU-[user|sys]/ ){
      our $workdir="/cgroup/cpuacct/lxc";
    }
    elsif( $mode =~ /MEM-/ ){
      our $workdir="/cgroup/memory/lxc";
    }
  }
}

#
# main loop
#
if($mode eq "PID"){
        (`lxc-info -n $name 2>&1` =~ m/[pid|PID]:([[:space:]]*)((-|[0-9])+)/) ? print_result("$2") : print_error("ERROR! Wront results");
}
elsif($mode eq "STATE"){
        (`lxc-info -n $name 2>&1` =~ m/[s|S]tate:([[:space:]]*)([A-Z]+)/) ? print_result("$2") : print_error("ERROR! Wront results ");
}
elsif($mode eq "CPU-sys"){
        (`cat $workdir/$name/cpuacct.stat 2>&1` =~ m/system([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_result("0");
}
elsif($mode eq "CPU-user"){
        (`cat $workdir/$name/cpuacct.stat 2>&1` =~ m/user([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_result("0");
}
elsif($mode eq "MEM-usage"){
        (`cat $workdir/$name/memory.usage_in_bytes 2>&1` =~ m/([0-9]+)/) ? print_result("$1") : print_error("ERROR! Wrong results");
}
elsif($mode eq "MEM-max-usage"){
        (`cat $workdir/$name/memory.max_usage_in_bytes 2>&1` =~ m/([0-9]+)/) ? print_result("$1") : print_error("ERROR! Wrong results");
}
elsif($mode eq "MEM-cache"){
        (`cat $workdir/$name/memory.stat 2>&1` =~ m/cache([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_error("ERROR! Wrong results");
}
elsif($mode eq "MEM-rss"){
        (`cat $workdir/$name/memory.stat 2>&1` =~ m/rss([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_error("ERROR! Wrong results");
}
elsif($mode eq "MEM-mapped_file"){
        (`cat $workdir/$name/memory.stat 2>&1` =~ m/mapped_file([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_error("ERROR! Wrong results");
}
elsif($mode eq "MEM-swap"){
        (`cat $workdir/$name/memory.stat 2>&1` =~ m/swap([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_error("ERROR! Wrong results");
}
elsif($mode eq "MEM-pgfault"){
        (`cat $workdir/$name/memory.stat 2>&1` =~ m/pgfault([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_error("ERROR! Wrong results");
}
elsif($mode eq "MEM-pgmajfault"){
        (`cat $workdir/$name/memory.stat 2>&1` =~ m/pgmajfault([[:space:]]*)([0-9]+)/) ? print_result("$2") : print_error("ERROR! Wrong results");
}
elsif($mode eq "NEXT"){

}
else{
 print STDERR "ERROR! Unknown mode\n";
 exit 1;
}


