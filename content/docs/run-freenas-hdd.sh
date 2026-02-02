#!/bin/bash
zfs get mountpoint /mnt/dpool/media/ftp
zfs set mountpoint=/dpool/media/ftp dpool/media/ftp
zfs get mountpoint dpool/media/ftp
zfs set mountpoint=legacy dpool/media/ftp
umount /mnt/sdd1
mount -o rw /dev/sdd1 /mnt/sdd1
./mountall.sh
cd /etc/init.d/
sudo gedit /etc/init.d/mountall.sh
sudo chmod +x mountall.sh
sudo update-rc.d mountall.sh defaults
less /var/log/syslog|  grep -i nfs
exit 0
