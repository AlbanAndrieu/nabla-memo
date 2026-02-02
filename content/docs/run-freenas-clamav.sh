#!/bin/bash
set -xv
iocage create -n "clamav" -p /tmp/pkg.json -r 11.3-RELEASE ip4_addr="vnet0|172.16.0.27/30" defaultrouter="172.16.0.1" vnet="on" \
  nat_forwards='tcp(9117)' \
  nat="on" allow_raw_sockets="1" boot="on" --basejail
add /mnt/dpool/workspace /mnt/dpool/iocage/jails/clamav/root/mnt/workspace
add /mnt/dpool/www /mnt/dpool/iocage/jails/clamav/root/mnt/www
iocage start clamav
iocage set boot=on clamav
freshclam
touch /var/log/clamav/freshclam.log
chmod 600 /var/log/clamav/freshclam.log
chown clamav /var/log/clamav/freshclam.log
edit /usr/local/etc/freshclam.conf
sysrc clamav_freshclam_enable="YES"
freshclam -d
sysrc clamav_clamd_enable="YES"
clamd --debug
iocage start clamav
ps -aux|  grep clam
clamscan -i -r -z -a -l /var/log/clamav/jab_clamscan000.log /mnt/www/
echo "https://172.17.0.2:10000/"
/var/log/clamav/freshclam.log
exit 0
