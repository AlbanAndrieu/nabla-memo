#!/bin/bash
set -xv
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
sudo apt install gnome-terminal
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.34.2-amd64.deb?utm_source=docker&
utm_medium=webreferral&
utm_campaign=docs-driven-download-linux-amd64
sudo apt-get install ./docker-desktop- < version > - < arch > .deb
docker context use desktop-linux
sudo systemctl stop docker docker.socket containerd
sudo systemctl disable docker docker.socket containerd
sudo systemctl --user start docker-desktop
sudo systemctl --user enable docker-desktop
sudo apt remove docker-desktop
rm -Rf ~/.docker/desktop
geany ~/.docker/config.json
key=$(gpg --no-auto-check-trustdb --list-secret-keys --with-colon|  grep ^sec|  cut -d: -f5)
echo -e "5\ny\n"|  gpg --command-fd 0 --expert --edit-key "$key" trust
pass show docker-credential-helpers|  sed -e 's/(.)/*/g'
docker context show
docker context ls
docker context use default
exit 0
