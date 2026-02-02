#!/bin/bash
set -xv
run-xrdp-install.sh -s
ls -lrta ~/.xsession*
sudo ufw allow 3389/tcp
rm -f ~/.xsession*
sudo apt-get install xrdp
sudo apt-get install gnome-session-flashback
cat << EOF > ~/.xsessionrc
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
EOF
sudo apt-get install xrdp-pulseaudio-installer
xrdp-build-pulse-modules
sudo systemctl restart xrdp.service
sudo systemctl status xrdp.service
sudo journalctl -xe
VBoxManage modifyvm "Windows7Misys" --vrde on
VBoxManage modifyvm "Windows7Misys" --vrdeport 5000,5010-5012
VBoxManage showvminfo "Windows7Misys"
vboxmanage modifyvm "Windows7Misys" --vrdeproperty "Security/Method=negotiate"
Display - Display > Remote
Server port : 5000
Authentication method : Guest
NAT
Port forwrding rule
RDP TCP 10 .25 .40 .139 5000 10 .0 .2 .15 3389
localhost:5001
10.25.40.139:5000
With RDP
Username : aandrieu
Domain : NABLA
Advanced - : RDP > Security
Advanced - clipboard sync > Disable
mstsc /v:10.41.40.40
rm -Rf ~/.freerdp
pkill vino
export DISPLAY=:0.0
/usr/lib/vino/vino-server&
3389
who -u
sudo adduser xrdp ssl-cert
exit 0
