#!/bin/bash
set -xv
sudo fdisk -l
mkfs.vfat -n CLE_VFAT /dev/sdg
sudo umount /dev/sdg
sudo mount /dev/sdg
sudo /media/windows
sudo mount -t ntfs -o nls=utf8,umask=0222 /dev/sdg /media/windows
sudo mount /media/windows
curl -1sLf \
  'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh'|sudo -E bash
sudo apt-get update
sudo apt-get install balena-etcher-electron
sudo add-apt-repository ppa:mkusb/ppa
sudo apt-get update
sudo apt-get install mkusb mkusb-nox usb-pack-efi
mkusb
udisksctl status
sudo parted -l
lsusb
sudo dosfsck -a -v /dev/sdd1
udisksctl status
sudo mount -t vfat /dev/sdg1 /media/usb -o uid=1000,gid=1000,utf8,dmask=027,fmask=137
sudo umount /media/usb
lspci -k
dconf-editor
gsettings get org.gnome.desktop.media-handling automount true
gsettings get org.gnome.desktop.media-handling automount-open true
sudo apt install dosfstools mtools
gparted
udevadm monitor
sudo apt install autofs udev
nano /etc/udev/rules.d/usb_auto_mount.rules
sudo nano /etc/auto.master
sudo apt install usbmount
sudo systemctl restart udev
exit 0
