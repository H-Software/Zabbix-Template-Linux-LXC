#!/usr/bin/perl

#use strict;

# Patrik Majer (patrik.majer.pisek@gmail.com)
#
# Zabbix 2 - LXC containers autodiscovery for linux
#
# all containers listed in cgroup/lxc are returned
#

@result = `ls /sys/fs/cgroup/lxc > /dev/null 2>&1`;

if ( $? == -1 ){
  #print "command failed: $!\n";
}
else {
  # printf "command exited with value %d", $? >> 8;

  if ( $? == 0 ){
    #debian
    our $command="find /sys/fs/cgroup/lxc/* -type d -exec ls -d {} \\;";
  }
  else {
    # centos or another OS
    our $command="find /cgroup/memory/lxc/* -type d -exec ls -d {} \\;";
  }
}

$first = 1;
print "{\n";
print "\t\"data\":[\n\n";

for (`$command 2>/dev/null`)
#for (`$command`)
{

 my @f = split('/', $_);

 #select last directory from path
 my $name = $f[-1];

 #strip whitespaces
 $name =~ s/\s*$//;

 #print result in JSON format
 print ",\n" if not $first;
 $first = 0;

 print "\t{";
 print "\t\"{#NAME}\":\"" . $name . "\"";
 print "}";

}

print "\n\t]\n";
print "}\n";

