#!/bin/bash
#set -xv

# main dns
while true; do dig google.fr @10.30.10.3 | grep "Quer"; done

# secondary dns
while true; do dig google.fr @10.30.10.4 | grep "Quer"; done

ping 8.8.8.8
ping -c 4 8.8.8.8

# https://medium.com/@ajonesb/resolving-sudden-dns-issues-on-ubuntu-a-step-by-step-guide-1f9ab1c27a32

# Issue : fix : Using degraded feature set TCP instead of UDP for DNS server 172.17.0.1
sudo chattr -i /etc/resolv.conf
sudo rm -f /etc/resolv.conf
sudo chmod 644 /etc/resolv.conf

sudo systemctl restart systemd-resolved.service
# sudo systemctl status systemd-resolved.service
sudo systemctl restart NetworkManager


# WARNING below will fail cloudflare-warp
sudo chattr +i /etc/resolv.conf

nslookup grafana.home.jasongodson.com

exit 0
