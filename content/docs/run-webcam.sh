#!/bin/bash
set -xv

VBoxManage list webcams

#Prevent gvfs from starting
apt-get install gconf2
gconftool-2 --type Boolean --set /apps/nautilus/preferences/media_automount false

#Disable webcam
#https://askubuntu.com/questions/528422/enabling-disabling-camera-from-terminal
sudo modprobe -r uvcvideo
#AND Maybe http://ubuntuforums.org/showthread.php?t=1340168
#sudo aptitude remove gvfs -P

#sudo modprobe -r videodev
#Enable webcam
sudo modprobe uvcvideo

lsof | grep video0
lsof | grep -i '/sys/bus'
ps -edf | grep motion
# lsof | grep -i '/dev/bus'
# lsof | grep -i '/dev/vide0 (or 1)'

#TODO disable wifi
#firmware-iwlwifi

#http://ubuntuforums.org/showthread.php?t=1340168
#sudo aptitude remove gvfs -P
#it will disable too much things
#1)      brasero
#2)      gnome-applets
#3)      gnome-session-flashback
#4)      gvfs-backends
#5)      gvfs-fuse
#6)      nautilus
#7)      nautilus-sendto
#8)      owasp-wte-fuzzdb
#9)      software-center

#https://github.com/markvdb/diybookscanner/wiki/Software-triggering-on-Debian-GNU-Linux#avoiding-competition-for-our-cameras
#sudo apt-get remove --purge gvfs-backends
#dpkg -s gvfs-backends|grep Status
#it will disable too much things

#dynamically enable and disable gphoto gvfs
gsettings set org.gnome.desktop.media-handling automount "false"
gsettings set org.gnome.desktop.media-handling automount-open "false"
#Obviously, to reverse:
#gsettings set org.gnome.desktop.media-handling automount "true"
#gsettings set org.gnome.desktop.media-handling automount-open "true"

gphoto2 --auto-detect

#identify webcam
lsusb -v
#us 001 Device 011: ID 046d:081b Logitech, Inc. Webcam C310

# https://www.maketecheasier.com/setup-motion-detection-webcam-ubuntu/
ps -edf | grep motion

#install webcam security tool
sudo apt-get install motion
cd ~
mkdir .motion

# check format
sudo v4l2-ctl -d /dev/video0 --list-formats-ext

sudo geany /etc/motion/motion.conf
# framerate 15
# picture_output on
# threshold 5500
# threshold_maximum 25000
# threshold_tune on
# pre_capture 10
# post_capture 10
webcontrol_localhost off
stream_localhost off
picture_filename %Y%m%d-%H%M%S-%q
# camera 2
video_device /dev/video2

chmod 777 ~/
chmod 777 ~/Dropbox
cd ~/Dropbox
ln -s /home/albandrieu/Dropbox/motion/ /var/lib/motion
sudo gpasswd -a ${USER} docker
# sudo chmod 776 /home/albandrieu/Dropbox/motion/
sudo chown albandrieu:adm /home/albandrieu/Dropbox/motion/

ctail -f /var/log/motion/motion.log

sudo systemctl enable --now motion.service
sudo systemctl restart motion.service

# check which process is using motion
lsof | grep -i '/sys/bus'

echo "http://localhost:8081 http://172.17.0.57:8082/"

sudo apt-get install wput
#on_picture_save wput ftp://user@password@server %f

# App to display camera
sudo apt-get install cheese
# CCS for 3D textures is disabled, but a workaround is available

sudo apt-get install cameractrls

exit 0
