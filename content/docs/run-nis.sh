#!/bin/bash
set -xv
sudo apt-get install nis
sudo service ypserv start
sudo service nis start
dpkg-reconfigure nis
systemctl stop autofs
ypwhich
yptest
ypdomainname
ls -lrta /var/yp/albandrieu.com/
ls -lrt /var/yp/binding/
exit 0
