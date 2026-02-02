#!/bin/bash
sudo apt-get install nfs-common
sudo apt-get install portmap rpcbind
./run-freenas-hdd.sh
showmount -e nabla
service portmap restart
service rpcbind restart
fuser -m /media/jenkins-slave
umount /media/jenkins-slave
mount /media/jenkins-slave
ls -lrta /media/jenkins-slave
resolvectl status
sudo apt-get install dconf-editor
dconf-editor
sudo service autofs stop
sudo automount -f -v
exit 0
