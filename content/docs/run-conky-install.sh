#!/bin/bash
set -xv

#http://doc.ubuntu-fr.org/conky

sudo add-apt-repository ppa:norsetto/ppa

sudo apt-get install conky-all
# sudo apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack lha arj cabextract file-roller
sudo apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller
sudo apt-get install nvidia-utils-550-server lm-sensors
nvidia-smi

#http://www.webupd8.org/2014/06/conky-manager-gets-revamped-ui-new.html
#NOK conky manager
# sudo apt-add-repository ppa:teejee2008/ppa
# sudo apt-get update
# sudo apt-get install conky-manager
# sudo apt-get remove conky-manager

# Install latest
# Try https://github.com/brndnmtthws/conky/issues/471
# https://github.com/brndnmtthws/conky/releases/tag/v1.11.5

sudo mv /usr/bin/conky /usr/bin/conky-SAV
cd ~/Downloads
# wget https://github.com/brndnmtthws/conky/releases/download/v1.11.4/conky-x86_64.AppImage
wget https://github.com/brndnmtthws/conky/releases/download/v1.21.7/conky-ubuntu-24.04-x86_64-v1.21.7.AppImage
sudo cp ./conky-ubuntu-24.04-x86_64-v1.21.7.AppImage /usr/bin/conky

#See https://linuxconfig.org/system-monitoring-on-ubuntu-18-04-linux-with-conky
chmod +x $HOME/.conky/conky-startup.sh

# See https://forum.ubuntu-fr.org/viewtopic.php?pid=1656078#p1656078
# See https://forum.ubuntu-fr.org/viewtopic.php?pid=1660467#p1660467

sudo nano /etc/init.d/conky
sudo systemctl status conky.service

# See https://unix.stackexchange.com/questions/537628/error-cannot-open-display-on-systemd-service-which-needs-graphical-interface
sudo nano /etc/systemd/user/conky.service

mkdir ~/.config/systemd/user/
~/.config/systemd/user/xsession.target
[Unit]
Description=Xsession running
BindsTo=graphical-session.target

systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
systemctl --no-block --user start xsession.target

exit 0
