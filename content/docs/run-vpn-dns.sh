#!/bin/bash
set -xv

#---------------------------------

# See https://github.com/systemd/systemd/issues/6076

sudo nano /etc/default/openvpn

OPTARGS="
    --script-security 2
    --up /etc/openvpn/up.sh
    --down /etc/openvpn/down.sh
"

#---------------

sudo nano /etc/openvpn/up.sh

#!/bin/sh

sudo systemd-resolve -i eno1 --set-dns=8.8.8.8 --set-domain="~."
#127.0.0.53
sudo systemd-resolve -i eno1 --set-domain="~bnt."
sudo systemctl restart systemd-resolved

#---------------

sudo nano /etc/openvpn/down.sh

#!/bin/sh

sudo systemd-resolve -i eno1 --set-domain="~."

#---------------------------------

sudo systemd-resolve --status

Link 70 (vpn0)
      Current Scopes: DNS
DefaultRoute setting: yes
       LLMNR setting: yes
MulticastDNS setting: no
  DNSOverTLS setting: no
      DNSSEC setting: no
    DNSSEC supported: no

# See https://unix.stackexchange.com/questions/316156/network-manager-not-taking-dns-search-into-account-for-vpn-gnome-ubuntu-16-04-1
ll /etc/NetworkManager/system-connections
#dns-search=albandrieu.com;finastra.global;.provides.io;

nm-connection-editor
#10.30.10.3,192.168.132.133
#albandrieu.com, int.jusmundi.com

systemctl restart NetworkManager.service

exit 0
