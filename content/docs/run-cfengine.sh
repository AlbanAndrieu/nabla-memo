#!/bin/bash
set -xv
sudo su - root
wget -qO- http://cfengine.com/pub/gpg.key|  apt-key add -
echo "deb http://cfengine.com/pub/apt/packages stable main" > /etc/apt/sources.list.d/cfengine-community.list
apt-get update
apt-get install cfengine2
ls /var/lib/cfengine3
ll /usr/share/doc/cfengine3
/usr/sbin/cfexecd
