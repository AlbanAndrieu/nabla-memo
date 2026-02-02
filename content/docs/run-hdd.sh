#!/bin/bash
#set -xv

sudo apt-get install xfsprogs
#sudo yum install xfsprogs

#Show disk

sudo fdisk -l
sudo fdisk -l /dev/nvme0n1
# change UUID
#sudo tune2fs -U random /dev/nvme0n1p2
#sudo tune2fs -U random /dev/nvme0n1
#sudo mount /dev/mapper/luksrecoverytarget /mnt/new2
#sudo tune2fs -U random /dev/mapper/luks-aa2b6221-413b-47f6-b1b4-2023ee770749
#sudo pvchange --uuid /dev/mapper/luks-aa2b6221-413b-47f6-b1b4-2023ee770749
#sudo vgchange --uuid

#sudo mkdir /mnt/new
#sudo mount /dev/nvme0n1p2 /mnt/new/

# Uncrypt luks fs
udisksctl unlock -b /dev/nvme0n1p3
#sudo cryptsetup luksUUID /dev/nvme0n1p3
##6e66dd76-261e-494f-b678-0fea74b8ffa0
sudo cryptsetup open /dev/nvme0n1p3 luksrecoverytarget
#/dev/mapper/luksrecoverytarget

#fdisk /dev/sda
#p

#/dev/sda1 is a non-LVM partition (Type: 0x83)
#/dev/sda2 is an LVM partition (Type: 0x8e)

#fdisk /dev/sdb

dmsetup status
dmsetup ls
dmsetup remove_all

#See https://doc.ubuntu-fr.org/lvm

#See https://www.gadgetdaily.xyz/cactus-for-mac-review-powerful-and-clean-web-development-tools/
#https://www.tecmint.com/extend-and-reduce-lvms-in-linux/

sudo lvscan

#sudo apt-get install system-config-lvm system-storage-manager kvpm
#system-config-lvm is no longer available in Centos 7 and has been replaced with system storage manager in Centos 7
#yum install system-storage-manager
#yum install gnome-disk-utility
#yum install baobab
sudo apt install partitionmanager gnome-disk-utility baobab

# disk space usage check
# gksudo baobab
# alternative to baoba is ncdu

#sudo ssm list

#Lunch the gui
#sudo system-config-lvm
#sudo kvpm

#gnome-disk-util
#Redhat GUI launch
#gnome-disks

#TODO see palimpsest

sudo vgchange -ay

man -k ^pv

lvm vgscan
lvm lvs

type lsblk > /dev/null 2>&1 || { echo >&2 "lsblk isn't installed. Abort"; exit 1; }

#See free space
sudo parted /dev/sda print free
sudo parted /dev/nvme0n1 print free
df -Th /root

#Change quota on xfs for oracle database

#1) The linux host machine *must* have a lvm partition of type xfs with d_type activated. This is done by formatting with: mkfs.xfs -n ftype=1 /dev/path_to_device,
#2) pquota *must* also be set on the xfs device. Read https://help.directadmin.com/item.php?id=557 for details,
#4) The container *must* be run with the options: --storage-opt size=35G --shm-size="8g" -p 1521:1521 -p 5500:5500 -p 5501:5501.

#nano /etc/default/grub
#GRUB_CMDLINE_LINUX="rd.lvm.lv=rhel_fr1cslvcacrhel71/swap rd.lvm.lv=rhel_fr1cslvcacrhel71/root rhgb quiet rootflags=uquota,pquota"

#cp /boot/grub2/grub.cfg /boot/grub2/grub.cfg.orig
#grub2-mkconfig -o /boot/grub2/grub.cfg

#sudo partprobe /dev/sdb
partprobe -s
#partx -v -a /dev/sda

#Add more disk space to VM
#First add another HDD in cloud, it will be visible in VM as sdb
#init disk for use by LVM
#pvcreate /dev/sdb

#SSD : intel rst premium with intel optane system acceleration
#Ubuntu
pvcreate /dev/sdb /dev/sdd
pvcreate /dev/sdc
lvm pvcreate -M 2 '/dev/nvme0n1p3'

#vgcreate vg_iscsi /dev/sdc1
vgcreate vg-docker /dev/nvme0n1p4
vgcreate vg_data /dev/sdc
# For workspace
vgcreate vg-nvme0n1 /dev/nvme0n1p3
#lvcreate --size 500G --name docker --type raid0  vg-nvme0n1
sudo lvcreate -l 100%FREE --name workspace-nvme0 vg-nvme0n1 /dev/nvme0n1p3
sudo vgcreate vg-docker /dev/nvme0n1p4
sudo lvcreate -l 100%FREE --name docker-nvme0 vg-docker /dev/nvme0n1p4

#lvcreate --size 500G --name data --mirrors 1 --type raid1 --nosync vg-nvme0n1
#lvcreate --size 500G --name games --mirrors 1 --type raid1 --nosync vg-nvme0n1
#vgcreate docker /dev/sdb

sudo mkfs -t ext4  /dev/vg-docker/docker-nvme0
sudo mkfs -t ext4  /dev/vg-nvme0n1/workspace-nvme0
#sudo mkfs -t ext4  /dev/vg-nvme0n1/data
#sudo mkfs -t ext4  /dev/vg-nvme0n1/games

#vgcreate vg-sata /dev/sdb /dev/sdd

# Check LVM RAID Status
sudo lvs -a -o name,copy_percent,devices vg-nvme0n1
sudo lvs -a -o name,copy_percent,devices vg-docker

# See https://blog.programster.org/create-raid-with-lvm
dm=$(basename $(readlink /dev/vg-nvme0n1/data))
sudo dmsetup table /dev/${dm}

sudo apt-get install scsitools
sudo rescan-scsi-bus
ls -1d /sys/class/scsi_device/*/device/block/*
#bash -c 'echo "1" > /sys/class/scsi_disk/2\:0\:2\:0/device/rescan'
echo 1>/sys/class/block/sdb/device/rescan
echo 1>/sys/class/block/sda/device/rescan
#OR
#echo 1>/sys/class/scsi_device/0\:0\:0\:0/device/block/sda/device/rescan
#echo 1>/sys/class/scsi_device/2\:0\:0\:0/device/block/sda/device/rescan
#sh -c 'echo "1" > /sys/class/scsi_disk/2\:0\:0\:0/device/rescan'

#On RedHat
#pvresize /dev/sdb

#On Ubuntu
#sudo apt-get install parted
#umount /dev/sda
#resize2fs /dev/sda1
#resize2fs /dev/sda1
#/usr/bin/mount -a
pvresize /dev/sdd1

#display attributes of disk
sudo pvdisplay
vgdisplay
lvdisplay

# Extends volume group. Please confirm group name.
#add disk to volume group
#RedHat
#vgextend rhel_fr1cslvcacrhel71 /dev/sdb
#vgextend VolGroup00 /dev/sdb
vgextend vg_iscsi /dev/sdc
#CentOS 7
vgextend centos_tmpvcaccent7 /dev/sdb
#vgextend rhel_fr1cslvcacrhel71 /dev/sdc

#Already create vgcreate by VMWare
#vgcreate docker /dev/xvdf
#vgcreate docker /dev/sdb

#Create vg_iscsi volume group
umount /data && vgcreate vg_iscsi /dev/sdd1

fdisk -l /dev/sdd1

# Free disk space should be now visible in VG. Actual number of available physical extents (PE) will be smaller,
# than expected with disk size, some of the space will be taken by metadata
vgdisplay
#vgdisplay -v rhel_fr1cslvcacrhel71
#vgdisplay -v VolGroup00

#RedHat
lvcreate -l 12805 -n workspace rhel_fr1cslvcacrhel71
lvcreate -l 12805 -n docker rhel_fr1cslvcacrhel71
#Ubuntu
#lvcreate -L 500G -n workspace vg_iscsi
#lvcreate -L 100G -n docker vg_iscsi
lvcreate -L 500G -n data vg_sata
lvcreate -L 1T -n docker vg_sata
#lvcreate --size 500G --name data --mirrors 1 --type raid1 --nosync vg-nvme0n1
#CentOS 7
lvcreate -l 12805 -n workspace centos_tmpvcaccent7
lvcreate -l 12794 -n docker centos_tmpvcaccent7

lvdisplay

#RedHat
#sudo mkfs -t ext4 /dev/rhel_fr1cslvcacrhel71/workspace
mkfs -t xfs /dev/rhel_fr1cslvcacrhel71/workspace
#sudo mkfs -t ext4 /dev/rhel_fr1cslvcacrhel71/docker
mkfs.xfs -n ftype=1 /dev/rhel_fr1cslvcacrhel71/docker
#Ubuntu
# yes | sudo mkfs.ext4 /dev/vg_iscsi/workspace
mkfs -t ext4 /dev/vg_iscsi/workspace
#mkfs -t ext4 /dev/vg_iscsi/docker
mkfs -t ext4 /dev/vg-sata/data
mkfs -t ext4 /dev/vg-sata/docker
#CentOS 7
mkfs -t xfs /dev/centos_tmpvcaccent7/workspace
mkfs.xfs -n ftype=1 /dev/centos_tmpvcaccent7/docker

sudo nano /etc/fstab
#/dev/vg-nvme0n1/data       /data       ext4    defaults,auto,_netdev 0 0
/dev/vg-nvme0n1/docker       /docker       ext4    defaults,auto,_netdev 0 0
/dev/vg_iscsi/workspace       /workspace        ext4    defaults,auto,_netdev 0 0
/dev/sdb1       /home/albandri       ext4    defaults,auto,_netdev 0 0
#/dev/sdc1       /home/albandrieu       ext4    defaults,auto,_netdev 0 0
/dev/nvme0n1p7   /media/albandrieu/data ext4    defaults,auto,_netdev 0 0
/dev/vg_data/data-sdc

# iscsi mounted
# nabla iscsi target is mounted on /workspace-remote
# ll /dev/disk/by-path/ip-192.168.132.24\:3260-iscsi-iqn.2011-03.com.albandrieu.istgt\:nabla-lun-1 -> sdf
/dev/vg_iscsi/workspace       /workspace-remote        ext4    defaults,auto,_netdev 0 0
# albandri iscsi target is mounted on /home-remote/albandri
# ll /dev/disk/by-path/ip-192.168.132.24\:3260-iscsi-iqn.2011-03.com.albandrieu.istgt\:albandri-lun-0 -> sdd
/dev/sdd1       /home-remote/albandri       ext4    defaults,auto,_netdev 0 0
# albandrieu iscsi target is a local user mounted on /home-remote/albandrieu
# ll /dev/disk/by-path/ip-192.168.132.24\:3260-iscsi-iqn.2011-03.com.albandrieu.istgt\:albandrieu-lun-0 -> sde
/dev/sde1       /home-remote/albandrieu       ext4    defaults,auto,_netdev 0 0

/dev/rhel_fr1cslvcacrhel71/workspace /workspace xfs auto 0 2
/dev/rhel_fr1cslvcacrhel71/docker /docker xfs defaults,usrquota,prjquota  0   0
#CentOS 7
/dev/centos_tmpvcaccent7/workspace /workspace xfs auto 0 2
/dev/centos_tmpvcaccent7/docker /docker xfs defaults,usrquota,prjquota  0   0

sudo mount -a

sudo mkdir /workspace
sudo mount /workspace

sudo mkdir /docker
sudo mount /docker

# Extends physical volume.
#extend size of logical volume
lvextend --resizefs -L +6G /dev/rhel_fr1cslvcacrhel71/swap
lvextend --resizefs -L +17G /dev/rhel_fr1cslvcacrhel71/root
lvextend -l +100%FREE /dev/rhel_fr1cslvcacrhel71/root
#lvextend -L +1G /dev/rhel_fr1cslvcacrhel71/docker
lvextend --resizefs -l +12805 /dev/mapper/rhel_fr1cslvcacrhel71-docker
#lvextend --resizefs -l +12805 /dev/rhel_fr1cslvcacrhel71/docker
lvextend --resizefs -l +12805 /dev/rhel_fr1cslvcacrhel71/workspace
#CentOS 7
lvextend --resizefs -L +6G /dev/mapper/centos_tmpvcaccent7-swap
lvextend --resizefs -L +17G /dev/mapper/centos_tmpvcaccent7-root
lvextend --resizefs -L +50G /dev/centos_tmpvcaccent7/docker
lvextend --resizefs -L +50G /dev/centos_tmpvcaccent7/workspace
# RedHat 6
lvextend --resizefs -L +8G /dev/VolGroup00/swapvol
lvextend --resizefs -L +2G /dev/VolGroup00/optvol
lvextend --resizefs -L +2G /dev/VolGroup00/varvol
lvextend --resizefs -L +2G /dev/VolGroup00/tmpvol
lvextend --resizefs -L +6G /dev/VolGroup00/usrvol
lvextend --resizefs -L +6G /dev/VolGroup00/rootvol

xfs_info /dev/mapper/rhel_fr1cslvcacrhel71-root
# extend size of mapped logical volume (only for xfs file system since RHEL7)
#xfs_growfs -d /dev/mapper/rhel_fr1cslvcacrhel71-root
xfs_growfs -d /dev/rhel_fr1cslvcacrhel71/root

#extend size of filesystem on Centos 6 and Ubuntu cinder block storage
#resize2fs /dev/rhel_fr1cslvcacrhel71/root
resize2fs /dev/mapper/VolGroup00-workspace

df -h
lsblk -o NAME,SIZE,GROUP,TYPE,FSTYPE,MOUNTPOINT

#https://supportex.net/blog/2010/11/determine-raid-controller-type-model/
sudo apt-get install mdadm dmraid
sudo dmraid -r

#Check hardware raid
# lspci -nn
lspci -vv | grep -i raids

#list full hardware
#lshw

#http://www.thegeekstuff.com/2014/07/hpacucli-examples
#hpacucli ctrl all show config

dmesg | grep sd
sudo fdisk -l
lsblk

cat /proc/scsi/scsi
ls -ld /sys/block/sd*/device
ls -la /dev/disk/by-id/

# https://www.howtoforge.com/tutorial/how-to-setup-iscsi-storage-server-on-ubuntu-1804/
#sudo apt-get install tgt
#sudo systemctl status tgt

fdisk /dev/sdc

#Command (m for help): <-- m
#Command action
#   a   toggle a bootable flag
#   b   edit bsd disklabel
#   c   toggle the dos compatibility flag
#   d   delete a partition
#   l   list known partition types
#   m   print this menu
#   n   add a new partition
#   o   create a new empty DOS partition table
#   p   print the partition table
#   q   quit without saving changes
#   s   create a new empty Sun disklabel
#   t   change a partition's system id
#   u   change display/entry units
#   v   verify the partition table
#   w   write table to disk and exit
#   x   extra functionality (experts only)
#
#Command (m for help): <-- n
#Command action
#   e   extended
#   p   primary partition (1-4)
#<-- p
#Partition number (1-4): <-- 1
#First cylinder (1-20480, default 1): <-- ENTER
#Using default value 1
#Last cylinder or +size or +sizeM or +sizeK (1-20480, default 20480): <-- ENTER
#Using default value 20480
#
#Command (m for help): <-- t
#Selected partition 1
#Hex code (type L to list codes): <-- L
#
# 0  Empty           1e  Hidden W95 FAT1 80  Old Minix       be  Solaris boot
# 1  FAT12           24  NEC DOS         81  Minix / old Lin bf  Solaris
# 2  XENIX root      39  Plan 9          82  Linux swap / So c1  DRDOS/sec (FAT-
# 3  XENIX usr       3c  PartitionMagic  83  Linux           c4  DRDOS/sec (FAT-
# 4  FAT16 <32M      40  Venix 80286     84  OS/2 hidden C:  c6  DRDOS/sec (FAT-
# 5  Extended        41  PPC PReP Boot   85  Linux extended  c7  Syrinx
# 6  FAT16           42  SFS             86  NTFS volume set da  Non-FS data
# 7  HPFS/NTFS       4d  QNX4.x          87  NTFS volume set db  CP/M / CTOS / .
# 8  AIX             4e  QNX4.x 2nd part 88  Linux plaintext de  Dell Utility
# 9  AIX bootable    4f  QNX4.x 3rd part 8e  Linux LVM       df  BootIt
# a  OS/2 Boot Manag 50  OnTrack DM      93  Amoeba          e1  DOS access
# b  W95 FAT32       51  OnTrack DM6 Aux 94  Amoeba BBT      e3  DOS R/O
# c  W95 FAT32 (LBA) 52  CP/M            9f  BSD/OS          e4  SpeedStor
# e  W95 FAT16 (LBA) 53  OnTrack DM6 Aux a0  IBM Thinkpad hi eb  BeOS fs
# f  W95 Ext'd (LBA) 54  OnTrackDM6      a5  FreeBSD         ee  EFI GPT
#10  OPUS            55  EZ-Drive        a6  OpenBSD         ef  EFI (FAT-12/16/
#11  Hidden FAT12    56  Golden Bow      a7  NeXTSTEP        f0  Linux/PA-RISC b
#12  Compaq diagnost 5c  Priam Edisk     a8  Darwin UFS      f1  SpeedStor
#14  Hidden FAT16 <3 61  SpeedStor       a9  NetBSD          f4  SpeedStor
#16  Hidden FAT16    63  GNU HURD or Sys ab  Darwin boot     f2  DOS secondary
#17  Hidden HPFS/NTF 64  Novell Netware  b7  BSDI fs         fd  Linux raid auto
#18  AST SmartSleep  65  Novell Netware  b8  BSDI swap       fe  LANstep
#1b  Hidden W95 FAT3 70  DiskSecure Mult bb  Boot Wizard hid ff  BBT
#1c  Hidden W95 FAT3 75  PC/IX
#Hex code (type L to list codes): <-- 83
#
#Command (m for help): <-- w
#The partition table has been altered!
#
#Calling ioctl() to re-read partition table.
#Syncing disks.

fdisk -l

#mkfs.ext4 /dev/sdd1

sudo mkdir -p /data
#sudo mkdir -p /media/iscsi/zvol-openstack
#sudo mkdir -p /media/iscsi/zvol-owncloud

#sudo mount /dev/sdd1 /data

ls -la /dev/disk/by-id/  | grep 6589cfc0000008c24bc3487156982765
# sdb albandri
ls -la /dev/disk/by-id/  | grep 6589cfc0000000d5e6acd678f4eaeaac
# sdc albandrieu

#sudo mount /dev/sdb1 /workspace/users/albandri
#sudo mount /dev/sdc1 /workspace/users/albandrieu

# See encrypted diks
# https://community.linuxmint.com/tutorial/view/2191#appc
modprobe dm-crypt
sudo update-grub
#Windows using BitLocker/TPM and Linux using dm-crypt with LUKS Enxtension

# Ubuntu 17 add swap
#http://linuxbsdos.com/2017/05/26/replace-the-swap-partition-with-a-swap-file-after-upgrading-to-ubuntu-17-04/

# Display amount of free and used memory
#free -m
free -h
# Display swap usage summary
swapon -s
# swapon --show
# Display user-process resource limits
ulimit -a

#https://askubuntu.com/questions/934391/how-to-resize-ubuntu-17-04-zesty-swap-file-size

swapoff /swapfile

#dd if=/dev/zero of=/swapfile bs=1024 count=65536
fallocate -l 50G /swapfile

#Change the permissions of the newly created file:

chmod 0600 /swapfile

#Setup the swap file with the command:

mkswap /swapfile

#To enable the swap file immediately but not automatically at boot time:

swapon /swapfile

#to enable swap on reboot
sudo nano /etc/fstab
/swapfile swap swap defaults 0 0

sudo nano /etc/sysctl.conf
sudo sysctl -p

#Resize
#rm -Rf /var/lib/docker/*
vgchange -a y
cd /
umount /docker
fdisk -l
lsblk
#ext 4 only
#e
# Update volume to take the new disk space into account with
lsblk -o NAME,SIZE,GROUP,TYPE,FSTYPE,MOUNTPOINT

# sudo umount /mnt/disk
sudo fdisk /dev/sdc
# sudo fdisk -l /dev/sdc
# sudo e2fsck -f /dev/sdc

# error on disk
# sudo fsck.ext4 /dev/sdb
# sudo fsck.ext4 /dev/sdc

# ERROR : Structure needs cleaning
sudo fsck -fy /dev/vg-sata/data
sudo fsck -fy /dev/vg-sata/docker

sudo resize2fs /dev/sdc

# FIX EXT4-fs error (device dm-6): ext4_lookup:1836: inode #18613222: comm find: iget: bad extra_isize 28338 (inode size 256)
# ext4-fs error bad block bitmap checksum
dmsetup ls
sudo dmsetup info /dev/dm-6
# vg--sata-data
ll /dev/vg-sata/data
sudo umount /dev/mapper/vg--sata-data
# fix target is busy
sudo umount -l /dev/vg-sata/data
sudo umount /data
sudo e2fsck -fy /dev/vg-sata/data
# sudo fsck.ext4 /dev/vg-sata/data  ## << accepted suggested fixes

#resize2fs /dev/mapper/centos_tmpvcaccent7-docker 4G
lvreduce -L -10G /dev/mapper/centos_tmpvcaccent7-docker

#sudo lvremove /dev/vg_iscsi/docker

#See https://docs.docker.com/storage/storagedriver/device-mapper-driver/#configure-direct-lvm-mode-for-production

lvcreate --wipesignatures y -n thinpoolmeta centos_tmpvcaccent7 -l 1%VG

sudo lvconvert -y \
--zero n \
-c 512K \
--thinpool centos_tmpvcaccent7/docker \
--poolmetadata centos_tmpvcaccent7/thinpoolmeta

nano /etc/lvm/profile/docker-thinpool.profile
activation {
  thin_pool_autoextend_threshold=80
  thin_pool_autoextend_percent=20
}

sudo lvchange --metadataprofile docker-thinpool centos_tmpvcaccent7/docker
sudo lvs -o+seg_monitor

nano /etc/docker/daemon.json
{
    "storage-driver": "devicemapper",
    "storage-opts": [
    "dm.thinpooldev=centos_tmpvcaccent7-docker",
    "dm.use_deferred_removal=true",
    "dm.use_deferred_deletion=true"
    ]
}

sudo systemctl start docker

journalctl -fu dm-event.service
lvs -a

# Copy
dd if=/dev/sda of=/dev/nvme0n1 bs=1M conv=noerror,sync status=progress

# GPT: Use GNU Parted to correct GPT errors
sgdisk -e

# https://www.it-connect.fr/chapitres/les-sauvegardes-avec-une-structure-lvm/
# vgcfgrestore --list vg_data

pvcreate --uuid physical-volume-uuid \
           --restorefile /etc/lvm/archive/volume-group-name_backup-number.vg \
           block-device

smartctl --scan

exit 0
