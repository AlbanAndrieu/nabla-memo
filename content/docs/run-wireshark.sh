#!/bin/bash
set -xv
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt-get install wireshark
sudo dpkg-reconfigure wireshark-common
sudo usermod -a -G wireshark $USER
sudo reboot
sudo ufw status
sudo ufw app info Samba
grep 17500 /etc/services
sudo service iptables restart
kubectl krew install sniff
kubectl sniff jenkins-master-7f5c756465-76scc -n jenkins -p --pod-creation-timeout 15m
exit 0
