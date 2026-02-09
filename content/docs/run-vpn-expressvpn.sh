#!/bin/bash
set -xv

# See https://www.expressvpn.com/support/vpn-setup/app-for-linux/#install

cd ~/Downloads/
sudo dpkg -i expressvpn_3.17.0.8-1_amd64.deb

# Express VPN Activation code : https://www.expressvpn.com/fr/setup#linux
expressvpn activate

expressvpn install-chrome-extension
expressvpn connect smart
#expressvpn connect defr1
#expressvpn connect pl
expressvpn status
expressvpn preferences set network_lock off
expressvpn preferences set block_trackers true
expressvpn disconnect

expressvpn autoconnect true

# See https://www.expressvpn.com/fr/setup#manual
# See https://www.expressvpn.com/fr/support/vpn-setup/manual-config-for-linux-ubuntu-with-openvpn/

#sudo apt purge expressvpn

firefox https://ipchicken.com/

# https://www.expressvpn.com/fr/support/troubleshooting/set-dns-servers-for-linux/
nmcli dev show | grep 'IP4.DNS'

# See https://www.lullabot.com/articles/fixing-docker-and-vpn-ip-address-conflicts
route -n

# See https://www.expressvpn.com/support/vpn-setup/pfsense-with-expressvpn-openvpn/

# See https://10.0.0.254:10443/vpn_openvpn_client.php?act=edit&id=2

# Fix OpenVPn Client opts

# Replace in Advanced Configuration > Custom options

# remote-random
# comp-lzo no
# verify-x509-name Server name-prefix
# ns-cert-type server
# route-method exe
# route-delay 2
# tun-mtu 1500
# fragment 1300
# mssfix 1200
# keysize 256

# BY

# fast-io;persist-key;persist-tun;remote-random;pull;comp-lzo;tls-client;verify-x509-name Server name-prefix;remote-cert-tls server;key-direction 1;route-method exe;route-delay 2;tun-mtu 1500;fragment 1300;mssfix 1450;verb 3;sndbuf 524288;rcvbuf 524288

# Also change
# Gateway creation -> IPV4 only

# https://10.0.0.254:10443/firewall_aliases.php
# ExpressVPN_Frankfurt  192.168.1.0 10.0.0.1/24

exit 0
