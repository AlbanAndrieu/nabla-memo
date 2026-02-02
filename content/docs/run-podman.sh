#!/bin/bash
set -xv
. /etc/os-release
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_$VERSION_ID/ /"|    sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_$VERSION_ID/Release.key|    sudo apt-key add -
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install podman
sudo systemctl start podman.socket
sudo service podman status
sudo curl -H "Content-Type: application/json" --unix-socket /var/run/docker.sock http://localhost/_ping
sudo podman ps
sudo podman network ls
sudo geany /etc/containers/registries.conf
podman pull --log-level debug docker.io/library/nginx:latest
podman --storage-driver=vfs info
podman info
rm -Rf /home/albandrieu/.local/share/containers/
podman stop -a&&  podman container prune -f&&  podman network prune -f
exit 0
