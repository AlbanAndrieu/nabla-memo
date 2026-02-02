#!/bin/bash
dmesg|  grep -A8 CD-ROM
sudo apt-get install libdvdcss2 libdvdread4 libdvdnav4 ubuntu-restricted-extras gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg
sudo apt-get install udftools
lshw|  less
sudo mount -o ro,unhide,uid=1000 /dev/sr0 /mnt/cdrom
cdrecord -checkdrive
vlc -vvv /dev/sr0
sudo mount -a
sudo eject /dev/sr0
exit 0
