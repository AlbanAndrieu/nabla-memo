#!/bin/bash
set -xv
sudo add-apt-repository ppa:norsetto/ppa
sudo apt-get install conky-all
sudo apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller
sudo apt-get install nvidia-utils-550-server lm-sensors
nvidia-smi
sudo mv /usr/bin/conky /usr/bin/conky-SAV
cd ~/Downloads
wget https://github.com/brndnmtthws/conky/releases/download/v1.21.7/conky-ubuntu-24.04-x86_64-v1.21.7.AppImage
sudo cp ./conky-ubuntu-24.04-x86_64-v1.21.7.AppImage /usr/bin/conky
chmod +x $HOME/.conky/conky-startup.sh
sudo nano /etc/init.d/conky
sudo systemctl status conky.service
sudo nano /etc/systemd/user/conky.service
mkdir ~/.config/systemd/user/
~/.config/systemd/user/xsession.target
[Unit]
Description=Xsession running
BindsTo=graphical-session.target
systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
systemctl --no-block --user start xsession.target
exit 0
