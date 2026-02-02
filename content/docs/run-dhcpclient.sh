#!/bin/bash
set -xv
sudo dhclient -v -r wlan1
sudo dhclient -v -r wlan1
sudo nano /etc/resolv.conf
sudo apt install resolvconf
dpkg-reconfigure resolvconf
sudo resolvconf -u
sudo nano /etc/resolvconf/resolv.conf.d/base
search home albandrieu.com albandrieu.com
sudo service network-manager restart
less /etc/resolv.conf
sudo apt-get purge modemmanager
sudo apt-get install modemmanager
domainname
less /etc/defaultdomain
systemctl status rpcbind
systemctl status ypbind
systemctl start ypbind
ypwhich
yptest
dmesg
service nis stop
./run-dns.sh
