#!/bin/bash
set -xv

# See https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-ubuntu-20-04

#sudo apt purge openvpn*
sudo apt install network-manager-openvpn-gnome network-manager-openvpn openvpn-systemd-resolved
sudo apt install openvpn easy-rsa
#mkdir ~/easy-rsa
#ln -s /usr/share/easy-rsa/* ~/easy-rsa/
#sudo chown $USER ~/easy-rsa

sudo sysctl -p

ip route list default

# See https://openvpn.net/vpn-software-packages/ubuntu/#modal-items

#sudo apt update && apt -y install ca-certificates wget net-tools gnupg
#wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
#echo "deb http://as-repository.openvpn.net/as/debian focal main">/etc/apt/sources.list.d/openvpn-as-repo.list
#apt update && apt -y install openvpn-as
#
#Admin  UI: https://192.168.132.57:943/admin
#Client UI: https://192.168.132.57:943/
#Login as "openvpn" with "XXXX" to continue

export USER_JM=${USER_JM:-"a.andrieu"}
export VPN_USER_JM="${USER_JM}"
export VPN_PASSWORD_JM=${VPN_PASSWORD_JM:-""}

# See https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/
export DISTRO=$(lsb_release -cs)
curl -fsSL https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub | gpg --dearmor >/etc/apt/trusted.gpg.d/openvpn-repo-pkg-keyring.gpg
curl -fsSL https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRO.list >/etc/apt/sources.list.d/openvpn3.list
sudo apt update
sudo apt install openvpn3

# get profile-135.ovpn from https://213.32.76.186
sudo openvpn --config /home/albandrieu/jm.ovpn
# ubuntu 20.04
openvpn2 --config /home/albandrieu/profile-135.ovpn --verb 6
openvpn3 session-start --config /home/albandrieu/jm.ovpn

#nano /etc/openvpn/update-resolv-conf
#foreign_option_1='dhcp-option DNS 10.30.10.3'
#foreign_option_3='dhcp-option DOMAIN int.jusmundi.com'

# DNS first job DNS
# 10.30.10.3, 192.168.132.133

# on gnome tick box on ipv4 : Use this connection only for resources on its network
# Open Network Manager (or nm-connection-editor in KDE) and click Add Network Using Configuration File (the name might change a bit).

# see https://askubuntu.com/questions/1033278/automatically-turn-on-vpn-on-computer-unlock-ubuntu-18-04
# for auto vpn connection
nm-connection-editor
#If you go into your WiFi connection settings for the AP you want to connect to the VPN on, there is an Always connect to VPN when using this connection: option, which you can enable, and select the VPN which you wish to automatically connect to.
"Use this connection only for resources on its network"
nmcli connection modifyjm ipv4.never-default yes

ping 10.11.0.15

# Import ovpn profile
sudo nmcli connection import type openvpn file ${HOME}/jm.ovpn
#unsupported blob/xml element (line 130) tls-crypt-v2

# lockout user
sudo /usr/local/openvpn_as/scripts/sacli --key "vpn.server.lockout_policy.reset_time" --value 1 ConfigPut
sudo /usr/local/openvpn_as/scripts/sacli --key "vpn.server.lockout_policy.reset_time" --value 600 ConfigPut

# https://github.com/strongswan/strongswan
ipsec status

exit 0
