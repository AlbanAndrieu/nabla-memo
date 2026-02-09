#!/bin/bash
#set -xv

sudo apt list | grep policykit

./run-xrdp-install.sh

systemctl status polkit

#  polkitd(authority=local)[2101414]: Registered Authentication Agent for unix-session:1 (system bus name :1.208 [/usr/bin/gnome-shell]

# Missing
/etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop

sudo apt install policykit-1-gnome

# geany /usr/share/polkit-1/rules.d/gnome-control-center.rules

exit 0
