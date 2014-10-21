Zabbix Template LXC
=========

A. Requirements
--

Templates were developed on:

```
Zabbix 2.0.x
Debian 7 x86_64 (turnkey linux) with kernel 3.2.0 and LXC 0.8.0
```

B. Installation
--

* copy file "zabbix-lxc.conf" into your zabbix-agent include folder

* copy file "sudoers.d-zabbix-agent" into /etc/sudoers.d folder (and install sudo package)

* copy scripts into /etc/zabbix/scripts folder (with 755 perms)

* import xml file as template into your zabbix-server


C. Monitored Items
--

through Discovery:

* PID of lxc container "{#NAME}"

* STATE of lxc container "{#NAME}"

* CPU acct (accumulated) - SYSTEM/USER - "{#NAME}"

* Memory Usage of "{#NAME}"

* Memory Usage Max. of "{#NAME}"

Memory advanced items:

* Memory cache

* Memory swap

* Memory rss

* Memory mapped_file

* Memory pgfault

* Memory pgmajfault


D. License
--

This template were distributed under GNU General Public License 2.

E. Docs
--

* http://blog.docker.com/2013/10/gathering-lxc-docker-containers-metrics/

* https://github.com/jangaraj/Zabbix-Docker-Monitoring

* https://github.com/LennartC/LXC-Monitor

* https://github.com/google/cadvisor

* https://www.zabbix.com/forum/showthread.php?t=42426

* https://github.com/ztmr/lxc-top

F. Copyright
--

Copyright (c) 2014 Patrik Majer

G.  Authors
--

Patrik Majer
      (patrik.majer.pisek |at| gmail |dot| com)
