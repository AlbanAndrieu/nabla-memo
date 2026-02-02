#!/bin/bash
sudo apt list|  grep policykit
./run-xrdp-install.sh
systemctl status polkit
/etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop
sudo apt install policykit-1-gnome
exit 0
