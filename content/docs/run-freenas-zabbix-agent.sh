#!/bin/bash
set -xv

pkg install zabbix6-agent

# See  run-freenas-zabbix.sh
sed -i '' 's/127.0.0.1/172.17.0.65/g' /usr/local/etc/zabbix6/zabbix_agentd.conf

edit /usr/local/etc/zabbix6/zabbix_agentd.conf
Server=172.17.0.65
ServerActive=172.17.0.65
Hostname=XXX
sysrc zabbix_agentd_enable="YES"
edit /etc/rc.conf
service zabbix_agentd restart

cat /var/log/zabbix/zabbix_agentd.log
tail -f /var/log/zabbix/zabbix_agentd.log

lsof -i :10050
# Unable to receive from [172.17.0.65]:10051 [ZBX_TCP_READ() timed out]
lsof -i :10051

netstat -tlpn | grep 10050

# In zabbix UI http://172.17.0.65/ need to add target/template freebsd

exit 0
