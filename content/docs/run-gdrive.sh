#!/bin/bash
set -xv
cd /workspace
sudo apt-get install fuse
sudo apt-get -f install
sudo wget https://launchpad.net/~invernizzi/+archive/google-docs-fs/+files/google-docs-fs_1.0~gdrive_all.deb
sudo dpkg -i google-docs-fs_1.0~gdrive_all.deb
sudo apt-get install -f
sudo mkdir drive
gmount drive alban.andrieu@nabla.mobi
gumount MON_REPERTOIRE_INITIAL
rm -Rf MON_REPERTOIRE_INITIAL
gmount REPERTOIRE_CIBLE user@gmail.com
sudo apt install python3-pydrive
exit 0
