#!/bin/bash
pkg upgrade
pkg install lsof
pkg install htop
cd /usr/ports&&  make search name=wget
cd /usr/ports/ftp/wget&&  make install clean
cd /usr/ports/editors/nano&&  make install clean
pkg install bash
run-freenas-zabbix-agent.sh
pkg install node_exporter
pkg install security/py-fail2ban
./run-freenas-wazuh-agent.sh
pkg install php-fpm_exporter
sysrc php-fpm_exporter=YES
service php-fpm_exporter start
pkg install devel/sonar-scanner-cli
pkg install devel/gitlab-runner
pkg install php-fpm_exporter
sysrc php-fpm_exporter=YES
service php-fpm_exporter start
pkg install bash nano node_exporter zabbix6-agent security/wazuh-agent security/py-fail2ban
sysrc php-node_exporter=YES
service php-node_exporter start
sysrc zabbix_agentd_enable="YES"
service zabbix_agentd restart
pkg remove cups
exit 0
