#!/bin/bash
set -xv

./run-hdd.sh

#ls -lah /dev/cciss/

#https://help.ubuntu.com/lts/serverguide/iscsi-initiator.html
sudo apt-get install open-iscsi # open-iscsi-utils
sudo geany /etc/iscsi/iscsid.conf
#uncomment
node.startup = automatic
sudo /etc/init.d/open-iscsi restart
systemctl restart open-iscsi

# See https://www.howtoforge.com/tutorial/how-to-setup-iscsi-storage-server-on-ubuntu-1804/
# On freenas in portal Discovery Auth Method to NONE AND Discovery Auth Group empty
#sudo iscsiadm -m discovery -t st -p 192.168.1.24
sudo iscsiadm -m discovery -t st -p 172.17.0.24 # 10.20.0.24 # 192.168.132.24
# Do not redon discovery it will reset login info
192.168.132.24:3260,-1 iqn.2011-03.com.albandrieu.istgt:albandri
192.168.132.24:3260,-1 iqn.2011-03.com.albandrieu.istgt:home
192.168.132.24:3260,-1 iqn.2011-03.com.albandrieu.istgt:nabla
#sudo iscsiadm -m node --logout

nano /etc/iscsi/nodes/iqn.2011-03.com.albandrieu.istgt\:nabla/192.168.1.24\,3260
node.session.auth.authmethod = CHAP
node.session.auth.username = albandri
node.session.auth.password = 65
node.session.auth.username_in = albandrieu
node.session.auth.password_in = 2y
#etc...

sudo iscsiadm -m node --login
#sudo iscsiadm --mode node --targetname iqn.2011-03.com.albandrieu.istgt:nabla --portal 192.168.1.24 --login
#sudo iscsiadm --mode node --targetname iqn.2011-03.com.albandrieu.istgt:albandri --portal 192.168.1.24 --login

#sudo systemctl restart open-iscsi # failing
service open-iscsi restart

# See https://www.cyberciti.biz/faq/howto-setup-debian-ubuntu-linux-iscsi-initiator/
nano /etc/iscsi/iscsid.conf
node.session.auth.authmethod = CHAP
node.session.auth.username = albandri
node.session.auth.password = 65
node.session.auth.username_in = albandrieu
node.session.auth.password_in = 2y

/etc/init.d/open-iscsi restart

# Identify the sessions that are still open:
iscsiadm -m session
iscsiadm -m node -T iqn.2011-03.com.albandrieu.istgt:nabla -p 192.168.132.24:3260 -u
# iscsiadm -m node -o delete -T iqn.2011-03.com.albandrieu.istgt\:nabla/192.168.132.24\,3260
rm iqn.2011-03.com.albandrieu.istgt\:nabla/192.168.132.24\,3260
rm iqn.2011-03.com.albandrieu.istgt\:nabla/10.20.0.24\,3260

# ./mountall.sh

sudo service open-iscsi status

sudo journalctl -xeu open-iscsi.service

exit 0
