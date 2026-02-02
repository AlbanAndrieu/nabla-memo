#!/bin/bash
while true;do  dig google.fr @10.30.10.3|  grep "Quer";done
while true;do  dig google.fr @10.30.10.4|  grep "Quer";done
ping 8.8.8.8
ping -c 4 8.8.8.8
sudo chattr -i /etc/resolv.conf
sudo rm -f /etc/resolv.conf
sudo chmod 644 /etc/resolv.conf
sudo systemctl restart systemd-resolved.service
sudo systemctl restart NetworkManager
sudo chattr +i /etc/resolv.conf
nslookup grafana.home.jasongodson.com
exit 0
