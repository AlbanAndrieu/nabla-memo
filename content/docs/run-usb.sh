#!/bin/bash
set -xv

sudo fdisk -l

#/dev/sdg

#mkfs.ntfs -n CLE_NTFS /dev/sdg
mkfs.vfat -n CLE_VFAT /dev/sdg

sudo umount /dev/sdg
sudo mount /dev/sdg
#sudo eject /dev/sdb

sudo /media/windows
sudo mount -t ntfs -o nls=utf8,umask=0222 /dev/sdg /media/windows
sudo mount /media/windows
#sudo mount -t vfat /dev/sdb1 /media/external -o uid=1000,gid=1000,utf8,dmask=027,fmask=137

# Burn image to usb
# See https://github.com/balena-io/etcher

curl -1sLf \
  'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' |
  sudo -E bash

sudo apt-get update
sudo apt-get install balena-etcher-electron

# Create FAT32 USB from ubuntu

# https://askubuntu.com/questions/909005/how-to-remove-read-only-from-usb-stick
sudo add-apt-repository ppa:mkusb/ppa
sudo apt-get update
sudo apt-get install mkusb mkusb-nox usb-pack-efi

mkusb
# p: Plug,   mkusb-plug          - New, easy to use

# See physical disk
udisksctl status

# https://askubuntu.com/questions/563764/usb-devices-showing-as-read-only
sudo parted -l
#sudo dosfsck /dev/sdd
lsusb
sudo dosfsck -a -v /dev/sdd1
udisksctl status

#sudo fsck /dev/sdd

# sudo umount /dev/sdd
# sudo mount -o uid=1000 /dev/sdd /media/usb
# sudo mount -o uid=1000 /dev/sdd1 /media/usb
sudo mount -t vfat /dev/sdg1 /media/usb -o uid=1000,gid=1000,utf8,dmask=027,fmask=137
#mount: /media/usb0: WARNING: source write-protected, mounted read-only.
# sudo umount /dev/sdd
# sudo hdparm -r0 /dev/sdd
# sudo mount -o remount,rw /dev/sdd
# sudo umount /dev/sdg1
sudo umount /media/usb

lspci -k
# USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller (rev 10)
# USB controller: Intel Corporation Tiger Lake-LP Thunderbolt 4 NHI #0 (rev 01)

# automount
# https://help.ubuntu.com/community/Mount/USB
dconf-editor

gsettings get org.gnome.desktop.media-handling automount true
gsettings get org.gnome.desktop.media-handling automount-open true

sudo apt install dosfstools mtools
gparted

# check kernel info on mounting
udevadm monitor

sudo apt install autofs udev
# https://www.baeldung.com/linux/automount-usb-device
nano /etc/udev/rules.d/usb_auto_mount.rules
# sudo udevadm control --reload-rules
# sudo systemctl daemon-reload

sudo nano /etc/auto.master
# /media/auto_mount_usb /etc/auto_mount.usb --timeout=60

sudo apt install usbmount
sudo systemctl restart udev

exit 0
