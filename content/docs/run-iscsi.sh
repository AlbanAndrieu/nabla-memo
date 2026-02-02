#!/bin/bash
set -xv
./run-hdd.sh
sudo apt-get install open-iscsi
sudo geany /etc/iscsi/iscsid.conf
node.startup = automatic
sudo /etc/init.d/open-iscsi restart
systemctl restart open-iscsi
sudo iscsiadm -m discovery -t st -p 172.17.0.24
192.168.132.24:3260,-1 iqn.2011-03.com.albandrieu.istgt:albandri
192.168.132.24:3260,-1 iqn.2011-03.com.albandrieu.istgt:home
192.168.132.24:3260,-1 iqn.2011-03.com.albandrieu.istgt:nabla
nano /etc/iscsi/nodes/iqn.2011-03.com.albandrieu.istgt\:nabla/192.168.1.24\,3260
node.session.auth.authmethod = CHAP
node.session.auth.username = albandri
node.session.auth.password = 65
node.session.auth.username_in = albandrieu
node.session.auth.password_in = 2y
sudo iscsiadm -m node --login
service open-iscsi restart
nano /etc/iscsi/iscsid.conf
node.session.auth.authmethod = CHAP
node.session.auth.username = albandri
node.session.auth.password = 65
node.session.auth.username_in = albandrieu
node.session.auth.password_in = 2y
/etc/init.d/open-iscsi restart
iscsiadm -m session
iscsiadm -m node -T iqn.2011-03.com.albandrieu.istgt:nabla -p 192.168.132.24:3260 -u
rm iqn.2011-03.com.albandrieu.istgt\:nabla/192.168.132.24\,3260
rm iqn.2011-03.com.albandrieu.istgt\:nabla/10.20.0.24\,3260
sudo service open-iscsi status
sudo journalctl -xeu open-iscsi.service
exit 0
