#!/bin/bash
set -xv
sudo apt-get install krb5-user
sudo apt-get install libpam-krb5
sudo modprobe rpcsec_gss_krb5
less /etc/krb5.conf
klist
grep passwd /etc/nsswitch.conf
pam-auth-update
exit 0
