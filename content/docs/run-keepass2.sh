#!/bin/bash
set -xv

# keepassx has no plugin
#sudo snap install keepassx

# http://maxolasersquad.blogspot.no/2013/10/install-keepasshttp-on-ubuntu.html
# See https://keepass.info/download.html

#sudo apt-add-repository ppa:jtaylor/keepass
#sudo apt-get update
#sudo apt-get install keepass2

# Install mono-complete https://www.mono-project.com/download/stable/
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update

sudo apt install mono-devel
mozroots --import --sync

# See https://connect.ed-diamond.com/MISC/misc-103/keepass-multiplateforme-en-authentification-forte-avec-une-yubikey
cd /usr/lib/keepass2/ || exit
#sudo mkdir plugins
#cd plugins
sudo cp ~/Downloads/KeePassOTP.plgx /usr/lib/keepass2/Plugins

sudo apt-get install git-core

sudo git clone -n https://github.com/pfn/keepasshttp.git --depth 1
cd keepasshttp || exit
sudo git checkout HEAD KeePassHttp.plgx

# Switch to https://github.com/keepassxreboot/keepassxc
# multipassd
# snap issue https://www.reddit.com/r/KeePass/comments/p10jbk/keepassxc_new_versions_do_not_detect_yubikey/
sudo snap remove keepassxc
# sudo snap connect "keepassxc:raw-usb" "core:raw-usb"
sudo apt remove keepassx
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt-get install keepassxc

sudo apt-get install webext-keepassxc-browser

exit 0
