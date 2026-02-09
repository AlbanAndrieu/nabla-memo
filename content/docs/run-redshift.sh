#!/bin/bash
set -xv

# See https://github.com/jonls/redshift/issues/445

sudo nano /etc/geoclue/geoclue.conf

[redshift]
allowed=true
system=false
users=

sudo apt-get remove redshift-gtk

exit 0
