#!/bin/bash
rm -Rf /usr/local/lib/webmin /usr/local/etc/webmin /var/db/webmin
pkg install perl5 webmin
/usr/local/lib/webmin/setup.sh
echo "webmin_enable="YES"" >> /etc/rc.conf
service webmin restart
tail -f /var/log/webmin/miniserv.error
echo "https://172.17.0.2:10000"
echo "https://172.17.0.34:10000"
echo "https://172.17.0.36:10000"
echo "https://172.17.0.106:10000"
echo "https://172.17.0.193:10000/"
ls -lrta /usr/local/etc/webmin/webalizer/
./run-webmin.sh
less /var/log/zabbix/auth.log
exit 0
