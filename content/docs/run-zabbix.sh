#!/bin/bash
set -xv
ifconfig
dhcpcd eth1
ls -lrta /usr/local/etc/zabbix/zabbix_agentd.conf
nano /etc/zabbix/zabbix_agentd.conf
zabbix_agentd
sudo su - root
sudo launchctl load -w /Library/LaunchAgents/org.macports.zabbix_agent.plist
sudo launchctl list
/etc/startzabbix.sh
tail -f /tmp/zabbix_agentd.log
svcs|  grep zabbix
svcadm refresh zabbix-agent
svcadm restart zabbix-agent
yum remove zabbix zabbix-agent zabbix-sender zabbix-get zabbix-*
rpm -Uvh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm
rpm -Uvh http://repo.zabbix.com/zabbix/3.4/rhel/6/x86_64/zabbix-release-3.4-1.el6.noarch.rpm
yum install zabbix30 zabbix30-agent
sudo apt-get remove zabbix-sender zabbix-get
sudo apt-get install zabbix-agent=1:3.0.12+dfsg-1
sudo apt purge zabbix-agent
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_latest+ubuntu24.04_all.deb
sudo apt update
sudo apt install zabbix-agent2 zabbix-agent2-plugin-*
sudo nano /etc/zabbix/zabbix_agent2.conf
Server=172.17.0.65
ServerActive=172.17.0.65
Hostname=albandrieu-Latitude-5420
rm -f /var/log/zabbix/zabbix_agentd.log
tail -f /var/log/zabbix/zabbix_agent2.log
sudo service zabbix-agent2 status
sudo systemctl enable zabbix-agent2
sudo apt install python3-pip
pip install dnspython
sudo zabbix_agentd -t agent.version
zabbix_agentd -t 'system.swap.size[,total]'
./run-auditd.sh
exit 0
