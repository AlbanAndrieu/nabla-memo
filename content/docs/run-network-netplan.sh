#!/bin/bash
set -xv
ping postgres-konga.service.gra.dev.consul
sudo apt install traceroute
traceroute postgres-konga.service.gra.dev.consul
sudo nano /etc/netplan/terraform.yaml
network:
version: 2
ethernets:
ens3:
dhcp4: true
nameservers:
search: [ int.jusmundi.com ]
addresses: [ 10.30.10.3, 10.30.10.4 ]
ssh root@213.32.77.107
nano /etc/netplan/50-cloud-init.yaml
network:
version: 2
ethernets:
ens3:
addresses:
- 10.30.10.110/24
gateway4:
- 10.30.10.254
nameservers:
addresses:
- 10.30.10.3
- 10.30.10.4
search:
- int.jusmundi.com
sudo netplan generate
sudo netplan apply
sudo less /etc/resolv.conf
sudo apt install net-tools
sudo netstat -ntlp
sudo netstat -tulpn|  grep LISTEN
sudo ufw allow 9252
sudo ufw status
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9252 -j ACCEPT
exit 0
