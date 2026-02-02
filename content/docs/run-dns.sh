#!/bin/bash
#set -xv

sudo nano /etc/hosts
#127.0.0.1   albandrieu.albandrieu.com albandrieu localhost
#192.168.132.93 albandrieu-dell-5420 albandrieu-dell-5420.int.jusmundi.com

sudo nano /etc/hostname
#albandrieu

hostname --fqdn
nano /etc/resolvconf/resolv.conf.d/head
#domain albandrieu.com
sudo resolvconf -u
hostnamectl

dnsdomainname

# See https://kinsta.com/fr/base-de-connaissances/vider-cache-dns/
# https://www.maketecheasier.com/flush-dns-cache-linux/

sudo nano /etc/resolvconf/resolv.conf.d/head
domain albandrieu.com
#nameserver 10.0.0.33
#nameserver 8.8.8.8
#nameserver 8.8.4.4
#nameserver 212.27.40.240
#nameserver 212.27.40.241
search home albandrieu.com

# Windows
ipconfig /flushdns
# Macosx
dscacheutil -flushcache
# linux
sudo apt install dnsutils
sudo systemd-resolve --flush-caches
sudo systemd-resolve --statistics
# Ubuntu 22.04
sudo resolvectl flush-caches
sudo resolvectl statistics

sudo systemctl restart systemd-resolved.service
#sudo systemctl restart dnsmasq
#sudo systemctl restart named
#sudo systemctl restart nscd

1 - Connect to VPN
2 - List the current DNS configuration
resolvectl dns
Global: 10.21.200.3 10.25.200.3 8.8.8.8 8.8.4.4
Link 82 (vpn0): 10.21.200.1 10.21.200.15
Link 81 (vethab4d67a):
Link 817 (veth762f5429):
Link 816 (veth34f8fccf):
Link 815 (veth951dff34):
Link 814 (veth0e642eec):
Link 813 (veth04a5c668):
Link 812 (veth65d1e14d):
Link 811 (veth6f3e617e):
Link 36 (vethf971af6):
Link 34 (vethe7832c0):
Link 32 (veth0b5390f):
Link 30 (veth1253809):
Link 28 (veth7fc37d3):
Link 24 (veth6294c2e):
Link 22 (vethb5574e9):
Link 20 (br-b6842053ecee):
Link 19 (docker0):
Link 18 (br-c8d6586f3aba):
Link 10 (cni0):
Link 9 (pan1):
Link 8 (flannel.1):
Link 7 (virbr1-nic):
Link 6 (virbr1):
Link 5 (virbr0-nic):
Link 4 (virbr0):
Link 3 (lxcbr0):
Link 2 (eno1): 192.168.1.1 2a01:cb00:d39:ba00:769d:79ff:fecb:fb6a fe80::769d:79ff:fecb:fb6a
3 - Set the DNS and DOMAIN for my VPN Link
resolvectl dns 82 10.21.200.1
resolvectl domain 82 my.vpn.domain
4 - Now I can resolve everything correctly
systemd-resolve google.com
systemd-resolve intranet.my.vpn.domain

# Use addguardhome
# See https://phoenixnap.com/kb/ubuntu-dns-nameservers

systemd-resolve --status | grep 'DNS Servers' -A2

# addguardhome
nmcli dev show | grep 'IP4.DNS'
# 192.168.132.133
# from office
# 192.168.3.251
# express vpn
# 10.26.0.1

# docker run --dns 192.168.132.133 --rm busybox nslookup google.com
docker run --network=host --rm busybox nslookup google.com

# 10.0.0.133, 192.168.132.1, 192.168.1.1

http://192.168.1.100:8680/

albandrieu.com
nabla.hd.free.fr
nabla.freeboxos.fr

10.0.0.33, 10.0.0.1, 192.168.132.1, 192.168.1.1

# Add Dust Verify

They sent me instructions:
 Copy the exact TXT record value shown by WorkOS
 In your DNS provider (Cloudflare based on your records), add a new TXT record:
- Name/Host: _workos
- Value: dust-domain-verification-XXX=XXX
 Wait a few minutes for propagation, then click "Verify" in Dust
Note: The TXT record must go to _workos.jusmundi.com specifically, not the root domain. You can verify it s configured correctly at
 https://www.nslookup.io/domains/_workos.jusmundi.com/dns-records/txt/before clicking Verify.

exit 0
