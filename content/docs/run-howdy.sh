#!/bin/bash
set -xv

# See https://github.com/boltgolt/howdy

deactivate
source deactivate
sudo ln -sv $(which pip3) /usr/bin/pip3

# Issue https://github.com/boltgolt/howdy/issues/265

# https://ubuntuhandbook.org/index.php/2024/10/howdy-ubuntu-2404/
# sudo add-apt-repository ppa:boltgolt/howdy
sudo add-apt-repository ppa:ubuntuhandbook1/howdy
sudo apt update
sudo apt install howdy
sudo apt install python3-numpy python3-opencv python3-dlib libpam-python dlib-models libinireader0
# sudo apt install --reinstall -y python3-opencv

# error: externally-managed-environment

# https://askubuntu.com/questions/1499209/not-able-to-install-howdy-in-ubuntu
# sudo ln /lib/security/howdy/cli.py /usr/local/bin/howdy
rm /usr/local/bin/howdy

# as root
#pip install opencv-python
pip3 install opencv-python
pip3 show dlib
# Issue : ModuleNotFoundError: No module named '_dlib_pybind11'
# https://stackoverflow.com/questions/65319162/from-dlib-pybind11-import-modulenotfounderror-no-module-named-dlib-pybind1
pip uninstall dlib --verbose
# will fix _dlib_pybind11
pip3 install dlib --break-system-packages
pip3 install numpy

sudo ln -s /lib/security/howdy/cli.py /usr/local/bin/howdy

ffmpeg -f v4l2 -list_formats all -i /dev/video2
sudo apt install ffmpeg
sudo apt install v4l-utils
#identify webcam
v4l2-ctl --list-devices
lsusb -v

sudo howdy version

# sudo howdy add
sudo howdy -U albanandrieu add
sudo howdy -U albanandrieu add
#headset

sudo howdy config
# sudo geany /usr/lib/security/howdy/cli/../config.ini

detection_notice = true # print text to notify when it attempts face detection.
disable-login = true    # does not use facial authentication for login.
use_cnn = true          # use the more accurate CNN model, but takes more time (a few seconds) and more power to run.

# Bus 001 Device 011: ID 05a7:40fc Bose Corp. USB2.1 Hub
# Bus 001 Device 011: ID 046d:081b Logitech, Inc. Webcam C310
#device_path = /dev/v4l/by-path/pci-0000:00:14.0-usb-0:2.3:1.0-video-index0
# Bus 003 Device 006: ID 1bcf:28c4 Sunplus Innovation Technology Inc. Integrated_Webcam_HD
#device_path = /dev/v4l/by-path/pci-0000:00:14.0-usb-0:6:1.0-video-index0

save_failed = true

mkdir /var/log/howdy/
cd /var/log/howdy/
ll /var/log/howdy/snapshots
ln -s /home/albanandrieu/Dropbox/howdy snapshots

# Change
device_path = /dev/video0

#sudo -i
#less /var/log/auth.log
#v4l2-ctl --device=/dev/video0 --all

sudo howdy list
sudo howdy test

gsettings get org.gnome.desktop.lockdown disable-lock-screen
#gsettings set org.gnome.desktop.lockdown disable-lock-screen 'false'

# See https://help.gnome.org/admin/system-admin-guide/stable/power-dim-screen.html.en

dm-tool lock
# No lightdm

sudo apt-get install --reinstall gnome-control-center
gnome-control-center

# ImportError: libx265.so.179: cannot open shared object file
#  File "/usr/lib/howdy/recorders/video_capture.py", line 6, in <module>
#    import cv2"
# NOK https://www.ubuntuupdates.org/package/core/focal/universe/base/libx265-179

# as root
root@albandrieu:~# pip3 install opencv-python --break-system-packages

./run-pam.sh
#Replace pam_howdy
auth [success=3 default=ignore] /usr/lib/security/howdy/pam_howdy.so max-tries=1
#by
#NOK auth [success=3 default=ignore] pam_python.so /lib/security/howdy/pam.py max-tries=1

exit 0
