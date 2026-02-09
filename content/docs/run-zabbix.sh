#!/bin/bash
set -xv

#http://www.zabbix.com/download.php
#See video https://www.youtube.com/watch?v=S_9XMcuYk5Q
#Download VMware / VirtualBox (.vmdk)
# cd /workspace
# mv ~/Downloads/Zabbix_2.2_x86_64.x86_64-2.2.2.vmx.tar.gz .
# tar -xvf Zabbix_2.2_x86_64.x86_64-2.2.2.vmx.tar.gz
# cd /workspace/Zabbix_2.2_x86_64-2.2.2

#Zabbix Server :
#Username = root
#Password = zabbix

#Zabbix FrontEnd:
#Username = Admin (capital A)
#Password = zabbix

ifconfig
dhcpcd eth1

#check inet address
#http://10.0.0.45/zabbix/

#Configuration files are placed in /etc/zabbix
#Zabbix logfiles are placed in /var/log/zabbix
#Zabbix frontend is placed in /usr/share/zabbix
#Home directory for user zabbix is /var/lib/zabbix

#Default install of zabbix with Chocolatey is in C:\Program Files\Zabbix Agent

#In order to install zabbix by hand on windows
#Download zabbix-agent for windows at http://www.zabbix.com/download.php
#Open cmd with run as Administrator
#REM cd C:\Program Files\Zabbix Agent
#REM zabbix_agentd.exe -c zabbix_agentd.conf -i
#REM zabbix_agentd.exe -c zabbix_agentd.conf -s
#REM C:\ProgramData\zabbix\zabbix_agentd.conf

#Disable Windows firewall
#I managed to connect zabbix-agent (VM 1) to zabbix server (VM 2), but I had to disable Windows firewall. Must allow port 10050 Inbound Connection in Firewall

# MacOSX
#See http://blog.oper-init.eu/2016/07/05/install-zabbix-agent-on-mac-osx/

ls -lrta /usr/local/etc/zabbix/zabbix_agentd.conf
#ls -lrta /usr/local/sbin/zabbix_agentd
nano /etc/zabbix/zabbix_agentd.conf
zabbix_agentd

# Test your file
# plutil /Library/LaunchAgents/org.macports.zabbix_agent.plist
sudo su - root
sudo launchctl load -w /Library/LaunchAgents/org.macports.zabbix_agent.plist
sudo launchctl list
# As jenkins user or root
/etc/startzabbix.sh
tail -f /tmp/zabbix_agentd.log

# Solaris
svcs | grep zabbix
svcadm refresh zabbix-agent
svcadm restart zabbix-agent

# Redhat centos
yum remove zabbix zabbix-agent zabbix-sender zabbix-get zabbix-*
#CentOS/RHEL 7:
rpm -Uvh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm
#CentOS/RHEL 6:
rpm -Uvh http://repo.zabbix.com/zabbix/3.4/rhel/6/x86_64/zabbix-release-3.4-1.el6.noarch.rpm
yum install zabbix30 zabbix30-agent

# ubuntu 18.04 issue
sudo apt-get remove zabbix-sender zabbix-get
sudo apt-get install zabbix-agent=1:3.0.12+dfsg-1

# ubuntu 24.04
# https://www.zabbix.com/download?zabbix=6.4&os_distribution=ubuntu&os_version=24.04&components=agent_2&db=&ws=
sudo apt purge zabbix-agent
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_latest+ubuntu24.04_all.deb
sudo apt update
sudo apt install zabbix-agent2 zabbix-agent2-plugin-*
# sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
sudo nano /etc/zabbix/zabbix_agent2.conf

# Change
# Server=172.17.0.65
Server=172.17.0.65
ServerActive=172.17.0.65
Hostname=albandrieu-Latitude-5420

rm -f /var/log/zabbix/zabbix_agentd.log
# tail -f /var/log/zabbix/zabbix_agentd.log
tail -f /var/log/zabbix/zabbix_agent2.log
# sudo systemctl restart zabbix-agent
sudo service zabbix-agent2 status
sudo systemctl enable zabbix-agent2

# on ubuntu 22.10 kinetic
# locally make sure some package are installed
sudo apt install python3-pip
pip install dnspython
# awxkit>=21.4.0
# dnspython>=2.3.0
# netaddr>=0.8.0
# packaging>=20.9
# requests>=2.28.1
# zabbix-api>=0.5.4

sudo zabbix_agentd -t agent.version
zabbix_agentd -t 'system.swap.size[,total]'

# https://www.zabbix.com/forum/zabbix-help/25746-zabbix-discoverer-processes-more-than-75-busy

# https://docs.ansible.com/ansible/latest/collections/community/zabbix/zabbix_inventory_inventory.html#ansible-collections-community-zabbix-zabbix-inventory-inventory

# Add SNMP service to FreeNAS for zabbix : https://172.17.0.24:7000/ui/services/snmp
# Add SNMP package/service to Pfsense for zabbix

# See  below to integrate
./run-auditd.sh

exit 0
