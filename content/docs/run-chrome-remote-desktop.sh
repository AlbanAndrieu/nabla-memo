#!/bin/bash
set -xv

#See https://medium.com/@vsimon/how-to-install-chrome-remote-desktop-on-ubuntu-18-04-52d99980d83e
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install ./chrome-remote-desktop_current_amd64.deb

# See https://cloud.google.com/solutions/chrome-desktop-remote-on-compute-engine?hl=fr

less ~/.chrome-remote-desktop-session
less /opt/google/chrome-remote-desktop/chrome-remote-desktop

# Chose Ubuntu xfce4 (Not Unity or MATE)
# First remove other UI on Ubuntu 21.04 (keeping only xfce4)
sudo apt remove ubuntu-desktop
sudo apt remove lightdm
sudo apt autoremove
sudo service lightdm stop
# Xfce works on Ubuntu 21.04 and google remote desktop (~/.xsessionrc) and local is using GDMSESSION #ubuntu-xorg
sudo apt install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils
sudo apt-get install xfce4 slim # on Ubuntu 21.04 (keeping only xfce4 with slim)
#ctrl alt F2
sudo chown -R albandri:albandri ~/ # fix issue on login wrong user id
sudo apt install -y xscreensaver

# for lxde
#echo "exec /usr/bin/lxsession -s Lubuntu -e LXDE" > ~/.chrome-remote-desktop-session
# for xfce4
#sudo apt install --assume-yes xscreensaver
#sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
# For Ubuntu 21.04
echo "exec /usr/bin/xfce4-session" >~/.chrome-remote-desktop-session

nano $HOME/.xprofile

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

# for cinnamon
#echo "exec /usr/bin/cinnamon-session-cinnamon2d" > ~/.chrome-remote-desktop-session

#sudo systemctl disable lightdm.service

gsettings get org.gnome.desktop.lockdown disable-lock-screen
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'

#ls -lrta /usr/share/polkit-1/actions/org.freedesktop.color.policy

# See https://c-nergy.be/blog/?p=14051
# See https://askubuntu.com/questions/1193810/authentication-required-to-refresh-system-repositories-in-ubuntu-19-10
cd /etc/polkit-1/localauthority/50-local.d
nano 45-allow-colord.pkla

[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device
org.freedesktop.color-manager.create-profile
org.freedesktop.color-manager.delete-device
org.freedesktop.color-manager.delete-profile
org.freedesktop.color-manager.modify-device
org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes

nano 46-allow-update-repo.pkla

[Allow Package Management all Users]
Identity=unix-user:*
Action=org.freedesktop.packagekit.system-sources-refresh
ResultAny=yes
ResultInactive=yes
ResultActive=yes

# Ubuntu 21.04
sudo Xorg -version
echo $GNOME_SESSION_MODE #
echo $XDG_SESSION_TYPE   #x11
echo $GDMSESSION         #ubuntu-xorg

./run-xrdp.sh

less ~/.xsessionrc

cat <<EOF >~/.xsessionrc
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
EOF

# See https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#troubleshooting

sudo systemctl unmask chrome-remote-desktop
sudo systemctl restart chrome-remote-desktop
sudo systemctl status chrome-remote-desktop@$USER
sudo systemctl restart chrome-remote-desktop@$USER

journalctl SYSLOG_IDENTIFIER=chrome-remote-desktop    # All logs
journalctl SYSLOG_IDENTIFIER=chrome-remote-desktop -e # Most recent logs
journalctl SYSLOG_IDENTIFIER=chrome-remote-desktop -b # Logs since reboot

exit 0
