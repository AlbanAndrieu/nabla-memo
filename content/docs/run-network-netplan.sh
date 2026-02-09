#!/bin/bash
set -xv

ping postgres-konga.service.gra.dev.consul

sudo apt install traceroute
traceroute postgres-konga.service.gra.dev.consul

# nano /etc/netplan/50-cloud-init.yaml
sudo nano /etc/netplan/terraform.yaml
network:
version: 2
ethernets:
ens3:
dhcp4: true
nameservers:
search: [ int.jusmundi.com ]
addresses: [ 10.30.10.3, 10.30.10.4 ]

# Rescue mode

# Add Ext-Net
ssh root@213.32.77.107

# mount /dev/sda1 /mnt/data
nano /etc/netplan/50-cloud-init.yaml

network:
version: 2
# renderer: networkd
ethernets:
ens3: # Change this to your network interface name
addresses:
- 10.30.10.110/24 # Your desired static IP and subnet mask
gateway4:
- 10.30.10.254 # Your gateway IP
nameservers:
addresses:
- 10.30.10.3
- 10.30.10.4
search:
- int.jusmundi.com

sudo netplan generate
sudo netplan apply

sudo less /etc/resolv.conf

# Check open port
sudo apt install net-tools
sudo netstat -ntlp
sudo netstat -tulpn | grep LISTEN

sudo ufw allow 9252

sudo ufw status
# for gitlab runner
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9252 -j ACCEPT

exit 0
