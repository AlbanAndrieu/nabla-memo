#!/bin/bash
set -xv

# See https://doc.ubuntu-fr.org/apparmor
# https://blog.stephane-robert.info/docs/securiser/durcissement/apparmor/

sudo apt install apparmor apparmor-utils apparmor-profiles apparmor-profiles-extra

sudo service apparmor stop
sudo dpkg-reconfigure apparmor
sudo nano /etc/apparmor.d/tunables/home.d/albandri
@{HOMEDIRS}+=/data1/home/
sudo systemctl restart apparmor.service

# snapd polkit error: Authorization requires interaction
systemctl status polkit dbus

mv ~/.config/dconf/ ~/.config/dconf.bak
gnome-control-center
#applications-cc-panel Failed to connect interface: access denied

#gnome-tweaks

# See https://ubuntu.com/server/docs/security-apparmor

sudo aa-status

sudo aa-complain bitwarden
#sudo mv /etc/apparmor.d/usr.sbin.dhcpd /etc/apparmor.d/usr.sbin.dhcpd-SAV
ll /etc/apparmor.d/

#Fix audit AVC apparmor="DENIED" operation="open" profile="/usr/sbin/cupsd"
#https://askubuntu.com/questions/645636/apparmor-with-cupsd-denied-in-logs

#See https://doc.ubuntu-fr.org/apparmor
sudo apt-get install apparmor-utils
#sudo aa-complain cupsd
#sudo aa-enforce cupsd

sudo apt-cache policy apparmor

sudo apt install apparmor-profiles

sudo systemctl reload apparmor.service

sudo apparmor_status

# Remove
#sudo systemctl disable apparmor.service

# Disable
#sudo service apparmor stop
#sudo update-rc.d -f apparmor remove

# snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks
sudo apparmor_parser -r /etc/apparmor.d/*snap-confine*
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap-confine*

systemctl enable --now apparmor.service
systemctl enable --now snapd.apparmor.service

# Issue https://ubuntuforums.org/showthread.php?t=2476226
# Disable
sudo ln -sf /etc/apparmor.d/usr.sbin.sssd /etc/apparmor.d/disable/
# Check
sudo apparmor_parser -rW /etc/apparmor.d/usr.sbin.sssd

sudo ln -sf /etc/apparmor.d/usr.sbin.dhcpd /etc/apparmor.d/disable/
sudo apparmor_parser -rW /etc/apparmor.d/usr.sbin.dhcpd

sudo systemctl status apparmor.service

# aa-teardown for apache2
sudo apt-get install libapache2-mod-apparmor
sudo a2enmod apparmor
sudo systemctl restart apache2

aa-complain /etc/apparmor.d/usr.sbin.apache2

sudo aa-logprof

sudo journalctl | grep -i apparmor | tail -n 10

cat /etc/apparmor.d/abstractions/apache2-common
cat /etc/apparmor.d/abstractions/web-data

sudo apt-get install phpsysinfo apparmor-profiles

exit 0
