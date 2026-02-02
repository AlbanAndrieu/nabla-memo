#!/bin/bash
set -xv
sudo nano /etc/geoclue/geoclue.conf
[redshift]
allowed=true
system=false
users=
sudo apt-get remove redshift-gtk
exit 0
