#!/bin/bash
set -xv

rm /etc/profile.d/tmout.sh
rm /etc/profile.d/pinerolo_profile.sh
rm /etc/security/limits.d/10.hardcore.conf
#rm /etc/security/faillock.conf
#rm /etc/security/pwquality.conf

# https://jay75chauhan.medium.com/%EF%B8%8Fsecure-linux-server-1bbbaaa465d6

sudo nano /etc/security/pwquality.conf
minlen = 12 minclass = 3

sudo nano /etc/sysctl.conf
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0

sudo sysctl -p

exit 0
