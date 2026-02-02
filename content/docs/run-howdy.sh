#!/bin/bash
set -xv
deactivate
source deactivate
sudo ln -sv $(which pip3) /usr/bin/pip3
sudo add-apt-repository ppa:ubuntuhandbook1/howdy
sudo apt update
sudo apt install howdy
sudo apt install python3-numpy python3-opencv python3-dlib libpam-python dlib-models libinireader0
rm /usr/local/bin/howdy
pip3 install opencv-python
pip3 show dlib
pip uninstall dlib --verbose
pip3 install dlib --break-system-packages
pip3 install numpy
sudo ln -s /lib/security/howdy/cli.py /usr/local/bin/howdy
ffmpeg -f v4l2 -list_formats all -i /dev/video2
sudo apt install ffmpeg
sudo apt install v4l-utils
v4l2-ctl --list-devices
lsusb -v
sudo howdy version
sudo howdy -U albanandrieu add
sudo howdy -U albanandrieu add
sudo howdy config
detection_notice = true
disable-login = true
use_cnn = true
save_failed = true
mkdir /var/log/howdy/
cd /var/log/howdy/
ll /var/log/howdy/snapshots
ln -s /home/albanandrieu/Dropbox/howdy snapshots
device_path = /dev/video0
sudo howdy list
sudo howdy test
gsettings get org.gnome.desktop.lockdown disable-lock-screen
dm-tool lock
sudo apt-get install --reinstall gnome-control-center
gnome-control-center
root@albandrieu:~# pip3 install opencv-python --break-system-packages
./run-pam.sh
auth [success=3 default=ignore] /usr/lib/security/howdy/pam_howdy.so max-tries=1
exit 0
