#!/bin/bash
set -xv

# sudo apt install ubuntu-gnome-desktop
sudo apt install gnome-shell-extensions
sudo apt install gnome-software
sudo apt install gnome-shell-extension-manager
sudo apt install gnome-software gnome-software-plugin-flatpak flatpak
sudo apt install gnome-tweaks
sudo apt install gnome-core

# unity-control-center

#sudo apt-get install --reinstall gnome-control-center
#sudo gnome-control-center display
gnome-control-center -v user-accounts
# /var/log/syslog Error acquiring permission: Failed to acquire permission for action-id org.gnome.controlcenter.user-accounts.administration

# See https://askubuntu.com/questions/1154747/how-can-i-give-permission-to-a-user-be-able-to-unlock-users-gui-to-create-new-us
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
#GNOME Shell 42.5 -> 48.0 (ubuntu 26)

system-config-printer

sudo apt-get install --reinstall gnome-software
sudo apt install --reinstall policykit-1-gnome

# https://www.halolinux.us/ubuntu-server-administration-2/restore-default-policykit-settings.html

dpkg -l | grep polkit
#sudo apt-get install --reinstall policykit-1

# pkaction --reset-defaults org.freedesktop.systemtoolsbackends.set
# pkaction --reset-defaults org.freedesktop.systemtoolsbackends.self.set
# pkaction --action-id org.freedesktop.packagekit.package-install --verbose

gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings get org.gnome.desktop.lockdown disable-lock-screen
# gsettings set org.gnome.desktop.lockdown disable-lock-screen false

gsettings get org.gnome.desktop.screensaver lock-enabled

gsettings get org.gnome.desktop.lockdown disable-lock-screen
# dconf write /org/gnome/desktop/lockdown/disable-lock-screen false

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
# gsettings set org.gnome.desktop.screensaver lock-enabled "true"
gsettings set org.gnome.desktop.session idle-delay 300

# Logout to pickup changes
# gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt

# Add in Startup Applications Preferences
/bin/xscreensaver -nosplash

sudo apt install gnome-bluetooth

sudo apt install gnome-shell-extension-manager
sudo apt install gnome-software gnome-software-plugin-flatpak flatpak

# Disable wayland for Ubuntu on Xorg
# https://askubuntu.com/questions/1341208/screen-share-show-black-screen-after-upgrade-from-ubuntu-20-10-to-21-04/1341213#1341213
sudo nano /etc/gdm3/custom.conf
#Uncomment the line
#WaylandEnable=false

AutomaticLoginEnable = true
AutomaticLogin = albandrieu

# Issue : ubuntu gnome settings daemon virtual terminal stopped device memory is nearly full
# https://askubuntu.com/questions/1266498/gnome-shell-is-taking-a-lot-of-ram
gnome-extensions list
gnome-extensions list --enabled
# pop-shell@system76.com
ubuntu-appindicators@ubuntu.com
ding@rastersoft.com
ubuntu-dock@ubuntu.com
tiling-assistant@ubuntu.com

gnome-extensions disable switch-x11-wayland@prasanthc41m.github.com

# gnome-extensions disable ubuntu-appindicators@ubuntu.com
gnome-extensions disable x11gestures@joseexposito.github.io
# gnome-extensions disable apps-menu@gnome-shell-extensions.gcampax.github.com
# gnome-extensions disable auto-move-windows@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable drive-menu@gnome-shell-extensions.gcampax.github.com
# gnome-extensions disable launch-new-instance@gnome-shell-extensions.gcampax.github.com
# gnome-extensions disable light-style@gnome-shell-extensions.gcampax.github.com
# gnome-extensions disable native-window-placement@gnome-shell-extensions.gcampax.github.com
# gnome-extensions disable places-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable system-monitor@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable window-list@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable windowsNavigator@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable workspace-indicator@gnome-shell-extensions.gcampax.github.com

# https://askubuntu.com/questions/959353/disable-gnome-software-from-loading-at-startup
# gnome-software g application service
sudo geany /etc/xdg/autostart/gnome-software-service.desktop
gsettings set org.gnome.software download-updates false

sudo apt reinstall gnome-software

# Add

exit 0
