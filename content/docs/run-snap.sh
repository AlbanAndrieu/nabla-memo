#!/bin/bash
#set -xv

./run-flatpak.sh

# See https://doc.ubuntu-fr.org/snap

sudo snap install snap-store

snap list
snap find libre

# Run
snap-store

# See account https://snapcraft.io/snap-store

snap refresh --time
sudo snap set system refresh.timer=sat,10:00~12:00

# Clean snap
snap list --all | awk '/désactivé|disabled/{print $1, $3}' | while read snapname revision; do sudo snap remove "$snapname" --revision="$revision"; done

# NetworkManager
nmcli d
nmcli c show docker0 | grep "IP"
nmcli c show "Wired connection 1" | grep "IP"

sudo systemctl restart snapd.service
journalctl -u snapd.service
#failed: exceeded maximum runtime of 1m1s
#Lookup api.snapcraft.io: no such host

journalctl --no-pager --since "2020-12-15 09:15" --until "2020-12-15 10:45"
#sudo systemctl status microk8s.daemon-kubelet

sudo snap stop microk8s
sudo snap start microk8s

systemctl status snap.microk8s.daemon-kubelet
sudo journalctl -u snap.microk8s.daemon-kubelet
#https://127.0.0.1:16443/apis/coordination.k8s.io/v1/namespaces/kube-node-lease/leases/albandrieu?timeout=10s
# See https://github.com/ubuntu/microk8s/issues/423
sudo systemctl restart snap.microk8s.daemon-kubelet
sudo systemctl restart snap.microk8s.daemon-flanneld

#sudo snap remove microk8s

# NOK sudo snap install direnv # apt instead
# NOK sudo snap install curl
sudo snap remove curl direnv pre-commit aws-cli ruff

sudo snap install teams-for-linux
sudo snap install authy
sudo snap install bitwarden
sudo snap install slack
sudo snap install code --classic
#sudo snap install keepassxc --classic
sudo snap install httpie

sudo snap install insomnia
sudo snap install postman
sudo snap install phpstorm
sudo snap install nmap
# sudo snap install pycharm-community --classic
# sudo snap install aws-cli --classic
./run-aws.sh
# sudo snap install pre-commit --classic
sudo snap install htop
sudo snap install zaproxy --classic

sudo apt install gnome-software-plugin-snap # snappy-debug
snappy-debug.security scanlog

# NOK snap connections semaphore
# https://snapcraft.io/install/whatsie/ubuntu
sudo snap install whatsie

exit 0
