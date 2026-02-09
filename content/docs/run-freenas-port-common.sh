#!/bin/bash
#set -xv

pkg upgrade

pkg install lsof
pkg install htop
#pkg install wget
cd /usr/ports && make search name=wget
cd /usr/ports/ftp/wget && make install clean

#pkg install nano
cd /usr/ports/editors/nano && make install clean

pkg install bash
#bash_completion
#ln -s /usr/local/bin/bash /bin/bash

run-freenas-zabbix-agent.sh
# pkg install webmin

pkg install node_exporter
# pkg install jail_exporter
# sysrc jail_exporter_enable=YES
# edit /usr/local/etc/rc.d/jail_exporter
# : ${jail_exporter_listen_address:="172.17.0.96:9452"}
# : ${jail_exporter_listen_address:=":9452"}
# service jail_exporter start

pkg install security/py-fail2ban

./run-freenas-wazuh-agent.sh

pkg install php-fpm_exporter
sysrc php-fpm_exporter=YES
service php-fpm_exporter start

pkg install devel/sonar-scanner-cli
pkg install devel/gitlab-runner

#pkg install jail_exporter
#sysrc jail_exporter=YES
#service jail_exporter start

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
