#!/bin/bash
set -xv
sudo apt install apparmor apparmor-utils apparmor-profiles apparmor-profiles-extra
sudo service apparmor stop
sudo dpkg-reconfigure apparmor
sudo nano /etc/apparmor.d/tunables/home.d/albandri
@{HOMEDIRS}+=/data1/home/
sudo systemctl restart apparmor.service
systemctl status polkit dbus
mv ~/.config/dconf/ ~/.config/dconf.bak
gnome-control-center
sudo aa-status
sudo aa-complain bitwarden
ll /etc/apparmor.d/
sudo apt-get install apparmor-utils
sudo apt-cache policy apparmor
sudo apt install apparmor-profiles
sudo systemctl reload apparmor.service
sudo apparmor_status
sudo apparmor_parser -r /etc/apparmor.d/*snap-confine*
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap-confine*
systemctl enable --now apparmor.service
systemctl enable --now snapd.apparmor.service
sudo ln -sf /etc/apparmor.d/usr.sbin.sssd /etc/apparmor.d/disable/
sudo apparmor_parser -rW /etc/apparmor.d/usr.sbin.sssd
sudo ln -sf /etc/apparmor.d/usr.sbin.dhcpd /etc/apparmor.d/disable/
sudo apparmor_parser -rW /etc/apparmor.d/usr.sbin.dhcpd
sudo systemctl status apparmor.service
sudo apt-get install libapache2-mod-apparmor
sudo a2enmod apparmor
sudo systemctl restart apache2
aa-complain /etc/apparmor.d/usr.sbin.apache2
sudo aa-logprof
sudo journalctl|  grep -i apparmor|  tail -n 10
cat /etc/apparmor.d/abstractions/apache2-common
cat /etc/apparmor.d/abstractions/web-data
sudo apt-get install phpsysinfo apparmor-profiles
exit 0
