#!/bin/bash
set -xv
sudo apt remove libpam-fprintd fprintd libfprint-2-tod1-goodix
./run-fingerprint-install.sh
sudo systemctl status fprintd.service
sudo pam-auth-update
sudo dpkg -i libfprint-2-tod1-broadcom_5.12.018-0ubuntu1~22.04.01_amd64.deb
gnome-control-center -v user-accounts
systemctl status polkit dbus
systemctl status fprintd.service
sudo fprintd-enroll
sudo fprintd-enroll -f right-middle-finger
sudo lsusb
sudo fprintd-verify
opensc-tool --list-readers
exit 0
