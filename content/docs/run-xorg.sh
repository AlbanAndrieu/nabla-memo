#!/bin/bash
set -xv
sudo apt-get remove xserver-xorg-video-all
sudo apt-add-repository ppa:xorg-edgers
sudo apt-get install ppa-purge
sudo ppa-purge xorg-edgers
sudo apt-get install compizconfig-settings-manager
sudo apt-get install lightdm
sudo dpkg-reconfigure lightdm
sudo apt-get install ubuntu-desktop
sudo nvidia-settings --uninstall
sudo apt-get remove --purge nvidia*
sudo apt-get remove --purge xserver-xorg-video-nouveau xserver-xorg-video-nv xserver-xorg-video-all
Reinstall all the things!
sudo apt-get install nvidia-common
sudo apt-get install xserver-xorg-video-nouveau
sudo apt-get install --reinstall libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-core
sudo dpkg-reconfigure xserver-xorg
gconftool-2 --recursive-unset /apps/compiz-1
sudo apt-get install dconf-editor dconf-tools
wget https://launchpad.net/~amith/+archive/ubuntutools/+build/3910667/+files/unity-reset_0.1-8_all.deb
sudo dpkg --install unity-reset_0.1-8_all.deb
unity-reset
sudo apt-get install unity-2d
sudo apt-get install ubuntu-desktop
sudo apt-get install compizconfig-settings-manager
sudo apt-get install compiz-plugins-extra
sudo apt-get install mesa-util
glxinfo|  grep OpenGL
sudo lshw -c video
sudo hwinfo --framebuffer
sudo hwinfo --monitor
lspci -vnn|  grep -i VGA
inxi -Gxx
Xorg -version
sudo Xorg -configure
ls /etc/X11/xorg.conf
sudo add-apt-repository ppa:ubuntu-x-swat/x-updates
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install nvidia-current
sudo service lightdm stop
sudo apt-get purge nvidia-current
sudo apt-get purge nvidia*
sudo apt-get install --reinstall xserver-xorg-video-intel libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-core
sudo dpkg-reconfigure xserver-xorg
sudo update-alternatives --remove gl_conf /usr/lib/nvidia-current/ld.so.conf
ls -d .X*
rm ~/.Xauthority
rm ~/.profile
rm .config/monitors.xml
rm /etc/X11/xorg.conf
sudo apt-get install --reinstall xorg
sudo reboot
sudo service lightdm start
ps -ef|  grep '[b]in/X'
ps -ef|  grep nolisten
xhost +
/usr/bin/xhost +albandri
/usr/bin/xhost +albandrieu
xauth info
xauth list
standarduser@localhost:~$ xauth list|  grep unix$(echo $DISPLAY|  cut -c10-12) > /tmp/xauth
standarduser@localhost:~$ sudo su
root@localhost:~$ xauth add $(cat /tmp/xauth)
nautilus
lsof -U +c 15|  cut -f1 -d' '|  sort|  uniq -c|  sort -rn|  head -3
xdpyinfo|  grep -e dimensions -e resolution
xrandr --listmonitors
xrandr -q
xrandr --size 1920x1024
xrandr --size 3840x2160
xrandr --size 32:9
sudo gtf 3840 2160 144
sudo cvt 3840 2160 144
sudo cvt -r 3840 2160 60
xrandr --newmode "3840x2160_144.00" 1833.14 3840 4200 4632 5424 2160 2161 2164 2347 -HSync +Vsync
ll /etc/X11/xorg.conf
Section "Screen"
Identifier "Screen0"
Device "Device0"
Monitor "Monitor0"
DefaultDepth 24
SubSection "Display"
Depth 24
EndSubSection
SubSection "Display"
Depth 16
Modes "1024x768" "800x600" "640x480"
EndSubSection
SubSection "Display"
Depth 24
Modes "1024x768" "800x600" "640x480"
EndSubSection
EndSection
find /sys/devices/ -iname edid
exit 0
