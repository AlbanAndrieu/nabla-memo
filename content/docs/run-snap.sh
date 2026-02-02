#!/bin/bash
./run-flatpak.sh
sudo snap install snap-store
snap list
snap find libre
snap-store
snap refresh --time
sudo snap set system refresh.timer=sat,10:00~12:00
snap list --all|  awk '/désactivé|disabled/{print $1, $3}'|  while read snapname revision;do  sudo snap remove "$snapname" --revision="$revision";done
nmcli d
nmcli c show docker0|  grep "IP"
nmcli c show "Wired connection 1"|  grep "IP"
sudo systemctl restart snapd.service
journalctl -u snapd.service
journalctl --no-pager --since "2020-12-15 09:15" --until "2020-12-15 10:45"
sudo snap stop microk8s
sudo snap start microk8s
systemctl status snap.microk8s.daemon-kubelet
sudo journalctl -u snap.microk8s.daemon-kubelet
sudo systemctl restart snap.microk8s.daemon-kubelet
sudo systemctl restart snap.microk8s.daemon-flanneld
sudo snap remove curl direnv pre-commit aws-cli ruff
sudo snap install teams-for-linux
sudo snap install authy
sudo snap install bitwarden
sudo snap install slack
sudo snap install code --classic
sudo snap install httpie
sudo snap install insomnia
sudo snap install postman
sudo snap install phpstorm
sudo snap install nmap
./run-aws.sh
sudo snap install htop
sudo snap install zaproxy --classic
sudo apt install gnome-software-plugin-snap
snappy-debug.security scanlog
sudo snap install whatsie
exit 0
