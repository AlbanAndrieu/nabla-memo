#!/bin/bash
set -xv
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main"|  sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install mono-devel
mozroots --import --sync
cd /usr/lib/keepass2/||  exit
sudo cp ~/Downloads/KeePassOTP.plgx /usr/lib/keepass2/Plugins
sudo apt-get install git-core
sudo git clone -n https://github.com/pfn/keepasshttp.git --depth 1
cd keepasshttp||  exit
sudo git checkout HEAD KeePassHttp.plgx
sudo snap remove keepassxc
sudo apt remove keepassx
sudo apt-get install keepassxc
sudo apt-get install webext-keepassxc-browser
exit 0
