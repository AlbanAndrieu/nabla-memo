#!/bin/bash
set -xv

# See https://github.com/3v1n0/libfprint/

#sudo snap install validity-sensors-tools
#sudo snap connect validity-sensors-tools:raw-usb
#sudo snap connect validity-sensors-tools:hardware-observe
#
#sudo validity-sensors-tools.initializer

# https://doc.ubuntu-fr.org/fingerprintgui
# NOK sudo apt-add-repository --yes ppa:fingerprint/fingerprint-gui

# https://askubuntu.com/questions/1417284/how-enable-fingerprint-in-ubuntu-22-04
#sudo apt install libfprint-2-tod1

# https://launchpad.net/~andch/+archive/ubuntu/staging-fprint
#sudo add-apt-repository ppa:andch/staging-fprint
#sudo apt update
#sudo apt install libfprint-2-tod1-goodix
#sudo apt upgrade libfprint-2-2 libfprint-2-tod1

# See https://doc.ubuntu-fr.org/fprint
sudo apt remove libpam-fprintd fprintd libfprint-2-tod1-goodix
# sudo apt install libpam-fprintd fprintd

./run-fingerprint-install.sh

# cd /home/albanandrieu/w/follow
# git clone https://gitlab.freedesktop.org/libfprint/fprintd.git
# git clone https://gitlab.freedesktop.org/libfprint/libfprint.git

sudo systemctl status fprintd.service
# Authorization denied to :1.1183 to call method 'EnrollStart' for device 'Broadcom Sensors': Not Authorized: net.reactivated.fprint.device.enroll

sudo pam-auth-update

# NOK
# wget http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_0.0.6-0ubuntu1~somerville1_amd64.deb
# sudo apt install ./libfprint-2-tod1-goodix_0.0.6-0ubuntu1~somerville1_amd64.deb
#sudo add-apt-repository -u ppa:3v1n0/libfprint-vfs0090
#sudo apt install libfprint-2-tod-vfs0090
#sudo dpkg -i libfprint-2-tod1-goodix_0.0.6-0ubuntu1_somerville1_amd64.deb

# SETTING UP FINGERPRINT READER DELL 5420
# broadcom is the good driver for fingerprint
# https://www.dell.com/support/home/fr-fr/product-support/product/latitude-5420-laptop/drivers
# http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-broadcom/
# sudo apt remove libfprint-2-tod1-goodix
# wget http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-broadcom/libfprint-2-tod1-broadcom_5.8.012.0-0ubuntu1~oem2_amd64.deb
# sudo dpkg -i libfprint-2-tod1-broadcom_5.8.012.0-0ubuntu1~oem2_amd64.deb
# libfprint-2-tod1-broadcom_5.8.012.0-0ubuntu1_oem2_amd64.deb seems to work
sudo dpkg -i libfprint-2-tod1-broadcom_5.12.018-0ubuntu1~22.04.01_amd64.deb
# See User settings -> Fingerprint Login
#sudo apt-get install --reinstall gnome-control-center
#sudo gnome-control-center display
gnome-control-center -v user-accounts
# /var/log/syslog Error acquiring permission: Failed to acquire permission for action-id org.gnome.controlcenter.user-accounts.administration
systemctl status polkit dbus

systemctl status fprintd.service

sudo fprintd-enroll
sudo fprintd-enroll -f right-middle-finger

sudo lsusb

# Broadcom Corp. 58200
sudo fprintd-verify

opensc-tool --list-readers

exit 0
