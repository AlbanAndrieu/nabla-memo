#!/bin/bash
set -xv
VBoxManage list webcams
apt-get install gconf2
gconftool-2 --type Boolean --set /apps/nautilus/preferences/media_automount false
sudo modprobe -r uvcvideo
sudo modprobe uvcvideo
lsof|  grep video0
lsof|  grep -i '/sys/bus'
ps -edf|  grep motion
gsettings set org.gnome.desktop.media-handling automount "false"
gsettings set org.gnome.desktop.media-handling automount-open "false"
gphoto2 --auto-detect
lsusb -v
ps -edf|  grep motion
sudo apt-get install motion
cd ~
mkdir .motion
sudo v4l2-ctl -d /dev/video0 --list-formats-ext
sudo geany /etc/motion/motion.conf
webcontrol_localhost off
stream_localhost off
picture_filename %Y%m%d-%H%M%S-%q
video_device /dev/video2
chmod 777 ~/
chmod 777 ~/Dropbox
cd ~/Dropbox
ln -s /home/albandrieu/Dropbox/motion/ /var/lib/motion
sudo gpasswd -a $USER   docker
sudo chown albandrieu:adm /home/albandrieu/Dropbox/motion/
ctail -f /var/log/motion/motion.log
sudo systemctl enable --now motion.service
sudo systemctl restart motion.service
lsof|  grep -i '/sys/bus'
echo "http://localhost:8081 http://172.17.0.57:8082/"
sudo apt-get install wput
sudo apt-get install cheese
sudo apt-get install cameractrls
exit 0
