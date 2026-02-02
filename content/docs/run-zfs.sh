#!/bin/bash
set -xv
sudo apt-get install zfsutils-linux zsys
zsysctl
dmesg|  grep ZFS
ls -l /dev/disk/by-id/
sudo zpool create -o ashift=9 dpool /dev/disk/by-id/ata-WDC_WD10EALX-759BA1_WD-WCATR7624246 -f
sudo zpool create -o ashift=9 apool /dev/disk/by-id/ata-WDC_WD10EALX-759BA1_WD-WCATR7615786 -f
sudo zfs create apool/ROOT
sudo zfs create apool/ROOT/ubuntu-albandri
sudo zpool status dpool
sudo zdb
sudo zfs create -o mountpoint=/mnt/backup dpool/backup
sudo zfs create -o mountpoint=/mnt/jenkins dpool/jenkins
sudo zfs snapshot dpool/jenkins@empty
sudo zfs snapshot dpool/backup@empty
sudo zfs list
sudo zfs get all dpool/jenkins
sudo zfs get mountpoint dpool/jenkins
sudo zfs get mounted dpool/jenkins
sudo zfs mount -a
cd /
sudo ln -s /mnt/jenkins jenkins
sudo chown -h jenkins:jenkins /jenkins
sudo chown jenkins:jenkins /mnt/jenkins
export JENKINS_HOME=/jenkins
sudo apt-get install jenkins
swap -d /dev/zvol/dsk/rpool/swap
zfs destroy rpool/swap
zfs create -V300G -b4k rpool/swap
swap -a /dev/zvol/dsk/rpool/swap
zfs list
sudo apt-get install --reinstall zfs-dkms
sudo dkms status
exit 0
