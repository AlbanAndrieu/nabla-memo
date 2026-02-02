#!/bin/bash
set -xv
sudo apt install gnome-shell-extensions
sudo apt install gnome-software
sudo apt install gnome-shell-extension-manager
sudo apt install gnome-software gnome-software-plugin-flatpak flatpak
sudo apt install gnome-tweaks
sudo apt install gnome-core
gnome-control-center -v user-accounts
nano /etc/polkit-1/localauthority/50-local.d/46-user-admin.pkla
[user admin]
Identity=unix-user:*
Action=org.gnome.controlcenter.user-accounts.administration
ResultAny=auth_admin_keep
ResultInactive=no
ResultActive=no
systemctl status polkit
systemctl status dbus
sudo software-properties-gtk
gnome-shell --version
system-config-printer
sudo apt-get install --reinstall gnome-software
sudo apt install --reinstall policykit-1-gnome
dpkg -l|  grep polkit
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings get org.gnome.desktop.lockdown disable-lock-screen
gsettings get org.gnome.desktop.screensaver lock-enabled
gsettings get org.gnome.desktop.lockdown disable-lock-screen
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300
/bin/xscreensaver -nosplash
sudo apt install gnome-bluetooth
sudo apt install gnome-shell-extension-manager
sudo apt install gnome-software gnome-software-plugin-flatpak flatpak
sudo nano /etc/gdm3/custom.conf
AutomaticLoginEnable = true
AutomaticLogin = albandrieu
gnome-extensions list
gnome-extensions list --enabled
ubuntu-appindicators@ubuntu.com
ding@rastersoft.com
ubuntu-dock@ubuntu.com
tiling-assistant@ubuntu.com
gnome-extensions disable switch-x11-wayland@prasanthc41m.github.com
gnome-extensions disable x11gestures@joseexposito.github.io
gnome-extensions disable drive-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable system-monitor@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable window-list@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable windowsNavigator@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable workspace-indicator@gnome-shell-extensions.gcampax.github.com
sudo geany /etc/xdg/autostart/gnome-software-service.desktop
gsettings set org.gnome.software download-updates false
sudo apt reinstall gnome-software
exit 0
