#!/bin/bash
#set -xv

# install webmin
# See https://doxfer.webmin.com/Webmin/Installation
rm -Rf /usr/local/lib/webmin /usr/local/etc/webmin /var/db/webmin
pkg install perl5 webmin

# pkg update
# cd /usr/ports && make search name=webmin
# ./run-freenas-port.sh
# NOK cd /usr/ports/sysutils/webmin && make install clean

#-----------------
#[jenkins] Installing webmin-1.941...
#After installing Webmin for the first time you should perform the following
#steps as root:
#
#* Configure Webmin by running
/usr/local/lib/webmin/setup.sh

#* Add webmin_enable="YES" to your /etc/rc.conf
echo "webmin_enable="YES"" >>/etc/rc.conf

#* Start Webmin for the first time by running
service webmin restart
#/usr/local/etc/rc.d/webmin start

#The parameters requested by setup.sh may then be changed from within Webmin
#itself.
#-----------------

tail -f /var/log/webmin/miniserv.error

echo "https://172.17.0.2:10000"
echo "https://172.17.0.34:10000"
echo "https://172.17.0.36:10000"
echo "https://172.17.0.106:10000"
echo "https://172.17.0.193:10000/"

ls -lrta /usr/local/etc/webmin/webalizer/

./run-webmin.sh
# cpan install DBI
# cpan install DBD::mysql

less /var/log/zabbix/auth.log

exit 0
