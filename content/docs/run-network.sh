#!/bin/bash
set -xv

sudo netplan apply
#sudo /etc/init.d/network-manager restart

#systemd-resolve --status | grep 'DNS Servers' -A2

sudo service NetworkManager restart
sudo service systemd-networkd status
sudo service warp-svc status
sudo systemctl disable warp-svc.service

# requestbin : Capture http such as curl
sudo docker run --rm -it -p 10000:8000 weshigbee/requestbin

sudo apt-get install etherape iptraf-ng nload avahi-utils iperf fping

# https://andrewdupont.net/2022/01/27/using-mdns-aliases-within-your-home-network/
avahi-publish -a albandrieu-Latitude-5420.work.local -R 192.168.3.189

iftop

iptraf
mtr google.com
nload
iperf -c 10.30.10.85
fping - a -g 10.30.10.85 10.30.10.86
nc -l 8080

# Error : Using degraded feature set TCP instead of UDP for DNS server
sudo nano /etc/systemd/resolved.conf
# DNSSEC=no
sudo systemctl restart systemd-resolved.service

ip link show
sudo service NetworkManager status
journalctl | cat --number
watch -n1 journalctl -xeu NetworkManager.service
sudo service tailscaled restart

# weird IP to check
# 99.77.135.82
# derp18b.tailscale.com # https://tailscale.com/kb/1181/firewalls#opnsense-and-pfsense
# server-18-239-50-90.ams58.r.cloudfront.net
# ec2-18-134-215-41.eu-west-2.compute.amazonaws.com
# par21s19-in-f14.1e100.net
# 37.221.212.147 	ATW Internet Kft.
# vps-00b75c4f.vps.ovh.net
# 104.18.18.125
# 104.18.25.157
# 172.65.251.78

exit 0
