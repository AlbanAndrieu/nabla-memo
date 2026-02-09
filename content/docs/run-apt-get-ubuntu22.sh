#!/bin/bash
#set -xv

sudo apt install openjdk-17-dbg

# https://www.makeuseof.com/must-have-gnome-shell-extensions-linux-desktop/

# https://askubuntu.com/questions/1187191/tracker-process-taking-lot-of-cpu

systemctl --user mask tracker-store.service tracker-miner-fs.service tracker-miner-rss.service tracker-extract.service tracker-miner-apps.service tracker-writeback.service
tracker reset --hard
#sudo reboot

# 22.10
curl -L https://pyenv.run | bash

sudo apt-get update && sudo apt-get install git make direnv -y
sudo apt install git openjdk-18-jre-headless
sudo apt install ruby-bundler ruby-dev
sudo apt install pipenv

sudo apt install apt-transport-https rpm ansible shellcheck
sudo apt install --no-install-recommends pass git pwgen xclip gnome-keysign gpa
sudo apt install meld curl wget
sudo apt install maven composer golang
sudo apt install libffi-dev libsqlite3-dev
sudo apt install podman-compose docker-compose pre-commit ansible-lint

npm i --dev jest-junit
npx mega-linter-runner --install
npx mega-linter-runner
npx cspell "**/*.{txt,js,md}"
npx markdown-link-check README.md
mega-linter-runner --flavor documentation

sudo gpasswd -a ${USER} docker

sudo ln -s /usr/bin/python3 /usr/bin/python

# Disable wayland
./run-gnome.sh

sudo apt install gnome-tweaks

# Issue removed ubuntu kinetic Release file
# See https://askubuntu.com/questions/91815/how-to-install-software-or-upgrade-from-an-old-unsupported-release
# sudo sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

sudo mkdir /var/log/ansible/
sudo mkdir /var/log/clamav/
sudo touch /var/log/clamav/clamav.log

sudo service logrotate restart

exit 0
