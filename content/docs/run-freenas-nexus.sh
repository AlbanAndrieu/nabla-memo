#!/bin/bash
set -xv

#nexus
http://albandrieu.com:8085/nexus/

Admin Portal:

http://192.168.132.24:8081/
http://172.17.0.24:8082/nexus/

# OLD nexus
pkg update -f
pkg install openjdk8 # openjdk20
service nexus restart

service nexus2 restart

service elasticsearch restart

pkg install nexus2-oss
======================================================================
Message from nexus2-oss-2.14.15 :
========================================================================
Nexus Repository Manager OSS 2.14.15 has been successfully installed!

To enable Nexus, add the following line to /etc/rc.conf[.local]:

nexus2_enable="YES"

IMPORTANT: Nexus runs by default as user nexus!

Configuration
=============
* Start Nexus 'service nexus start'
* Open the following URL in your browser: http://localhost:8081/nexus
* Log in with the admin account 'admin/admin123', configure Nexus and
change this password immediately!

Common Locations
================
The configuration files can be found at:
/usr/local/etc/nexus2

The work, log, and run directories are located at:
* /var/nexus2
* /var/log/nexus2
* /var/run/nexus2

#rm -R /var/nexus2
#ln -s /media/nexus /var/nexus2

echo 'nexus2_enable="YES"' >>/etc/rc.conf

# Disable  IPv6
#ipv6_activate_all_interfaces="YES"nexus_enable="YES"USER="nexus"

service nexus2 start

#http://192.168.1.61:8081/nexus
# old nexus http://172.17.0.24:8081/
http://192.168.1.24:8081/
less /usr/home/nexus/sonatype-work/nexus3/admin.password

http://albandrieu.com:8085/nexus/

iocage fetch -P nexus-oss -g https://github.com/rebasing-xyz/iocage-nexus-oss.gi --branch main

#Unable to retrieve INDEX of /mnt/dpool/iocage/.plugins/github_com_rebasing-xyz_iocage-nexus-oss_git at /mnt/dpool/iocage/.plugins/github_com_rebasing-xyz_iocage-nexus-oss_git/INDEX.
#cd /mnt/dpool/iocage/.plugins/github_com_rebasing-xyz_iocage-nexus-oss_git/

iocage -D fetch -P nexus-oss.json --branch main

cd /home/nexus/sonatype-work/nexus3
tail -f /home/nexus/sonatype-work/nexus3/log/nexus.log

#172.16.0.10 to 172.16.0.11

# java.lang.NoClassDefFoundError: org/apache/karaf/specs/locator/OsgiLocator

# find /usr/share/ -name 'nexus.vmoptions'
#
# edit /home/nexus/nexus-3.38.1-01/bin/nexus.vmoptions
# -Djava.endorsed.dirs=lib/endorsed

exit 0
