#!/bin/bash
set -xv
https://launchpad.net/ubuntu/+source/webkitgtk
echo -e "# For Tizen studio\ndeb http://cz.archive.ubuntu.com/ubuntu bionic main universe"|  sudo tee /etc/apt/sources.list.d/tizen-bionic-libwebkitgtk.list
sudo apt-get install libwebkitgtk-1.0-0
sudo add-apt-repository ppa:linuxuprising/libpng12
sudo apt-get update
sudo apt-get install libpng12-0
sudo apt-get install expect
ls -lrta /home/albandrieu/tizen-studio
ls -lrta /home/albandrieu/tizen-studio-data
exit 0
