#!/bin/bash
set -xv
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install ./chrome-remote-desktop_current_amd64.deb
less ~/.chrome-remote-desktop-session
less /opt/google/chrome-remote-desktop/chrome-remote-desktop
sudo apt remove ubuntu-desktop
sudo apt remove lightdm
sudo apt autoremove
sudo service lightdm stop
sudo apt install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils
sudo apt-get install xfce4 slim
sudo chown -R albandri:albandri ~/
sudo apt install -y xscreensaver
echo "exec /usr/bin/xfce4-session" > ~/.chrome-remote-desktop-session
nano $HOME/.xprofile
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx
gsettings get org.gnome.desktop.lockdown disable-lock-screen
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
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
sudo Xorg -version
echo $GNOME_SESSION_MODE
echo $XDG_SESSION_TYPE
echo $GDMSESSION
./run-xrdp.sh
less ~/.xsessionrc
cat << EOF > ~/.xsessionrc
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
EOF
sudo systemctl unmask chrome-remote-desktop
sudo systemctl restart chrome-remote-desktop
sudo systemctl status chrome-remote-desktop@$USER
sudo systemctl restart chrome-remote-desktop@$USER
journalctl SYSLOG_IDENTIFIER=chrome-remote-desktop
journalctl SYSLOG_IDENTIFIER=chrome-remote-desktop -e
journalctl SYSLOG_IDENTIFIER=chrome-remote-desktop -b
exit 0
