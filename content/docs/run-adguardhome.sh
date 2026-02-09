#!/bin/bash
set -xv

# See https://ubuntu.com/appliance/adguard/vm

sudo snap install multipass
multipass launch appliance:adguard-home --name adguard-home
multipass list

# See https://adguardhome.albandrieu.com/

multipass shell adguard-home

#sudo snap install adguard-home

# on freenas http://172.17.0.24

# On router https://192.168.1.1/ replace DNS default by
212 27 40 240 - >192.168.1.5
212 27 40 241

# on workstation replace DNS default by 172.17.0.24

# Use addguardhome on workstation 192.168.132.57
# See https://phoenixnap.com/kb/ubuntu-dns-nameservers
nano /usr/local/bin/AdGuardHome.yaml

# See https://serverfault.com/questions/1030064/docker-cant-resolve-dns-names-outside-of-docker-network-receiving-read-from-dn

# See allowlist
# https://github.com/hl2guide/AdGuard-Home-Whitelist/tree/main
# https://github.com/hl2guide/AdGuard-Home-Whitelist/blob/main/USAGE.md

# See http://172.17.0.24:30004/#custom_rules
@@ || slackb.com^$important
@@ || exp.notion.so^$important

exit 0
