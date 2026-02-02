#!/bin/bash
set -xv
service mysql-server start
service zabbix_server start
cd /usr/local/etc/zabbix6
find -name 'api_jsonrpc.php' /usr/local/etc/zabbix6
less /var/log/zabbix/zabbix_agentd.log
exit 0
