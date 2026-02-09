#!/bin/bash
set -xv

# pkg mysql80-server... - zabbix6-server.

service mysql-server start
service zabbix_server start

cd /usr/local/etc/zabbix6

find -name 'api_jsonrpc.php' /usr/local/etc/zabbix6

# See http://172.17.0.65/

less /var/log/zabbix/zabbix_agentd.log

exit 0
