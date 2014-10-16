#!/usr/bin/perl

# Patrik Majer (patrik.majer.pisek@gmail.com)
#
# Zabbix 2 - LXC containers autodiscovery for linux
#
# all parameters listed in /sys/fs/cgroup/lxc/ are returned
#

# give lxc name
#sub get_vmname_by_id
#  {
#  $vmname=`cat /etc/qemu-server/$_[0].conf | grep name | cut -d \: -f 2`;
#  $vmname =~ s/^\s+//; #remove leading spaces
#  $vmname =~ s/\s+$//; #remove trailing spaces
#  return $vmname
#  }

$first = 1;
print "{\n";
print "\t\"data\":[\n\n";

for (`find /sys/fs/cgroup/lxc/* -type d -exec ls -d {} \\;`)
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


