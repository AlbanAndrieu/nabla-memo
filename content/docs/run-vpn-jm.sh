#!/bin/bash
set -xv
sudo apt install network-manager-openvpn-gnome network-manager-openvpn openvpn-systemd-resolved
sudo apt install openvpn easy-rsa
sudo sysctl -p
ip route list default
export USER_JM=${USER_JM:-"a.andrieu"}
export VPN_USER_JM="$USER_JM"
export VPN_PASSWORD_JM=${VPN_PASSWORD_JM:-""}
export DISTRO=$(lsb_release -cs)
curl -fsSL https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub|  gpg --dearmor > /etc/apt/trusted.gpg.d/openvpn-repo-pkg-keyring.gpg
curl -fsSL https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRO.list > /etc/apt/sources.list.d/openvpn3.list
sudo apt update
sudo apt install openvpn3
sudo openvpn --config /home/albandrieu/jm.ovpn
openvpn2 --config /home/albandrieu/profile-135.ovpn --verb 6
openvpn3 session-start --config /home/albandrieu/jm.ovpn
nm-connection-editor
"Use this connection only for resources on its network"
nmcli connection modifyjm ipv4.never-default yes
ping 10.11.0.15
sudo nmcli connection import type openvpn file $HOME/jm.ovpn
sudo /usr/local/openvpn_as/scripts/sacli --key "vpn.server.lockout_policy.reset_time" --value 1 ConfigPut
sudo /usr/local/openvpn_as/scripts/sacli --key "vpn.server.lockout_policy.reset_time" --value 600 ConfigPut
ipsec status
exit 0
