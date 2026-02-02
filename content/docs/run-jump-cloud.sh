#!/bin/bash
set -xv
echo "https://console.eu.jumpcloud.com/userconsole#/security"
curl --tlsv1.2 --silent --show-error --header 'x-connect-key: XXX' https://kickstart.eu.jumpcloud.com/Kickstart|  sudo bash
cd /opt/jc/
sudo apt remove jcagent*
ll /usr/lib/systemd/system/jcagent.service
ll /usr/lib/systemd/user/jumpcloud-user-agent.service
systemctl disable jcagent.service
systemctl disable jumpcloud-user-agent.service --user
systemctl disable remote-assist-launcher.service
systemctl disable remote-assist-service.service
rm -Rf /etc/systemd/system/remote-assist-launcher.service
rm -Rf /etc/systemd/system/remote-assist-service.service
ls -lrta /etc/profile.d/jc-raal.sh
exit 0
