#!/bin/bash
set -xv
egrep -c '(vmx|svm)' /proc/cpuinfo
egrep -c ' lm ' /proc/cpuinfo
sudo apt-get install -y cpu-checker
sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo apt-get purge kvm qemu-kvm
sudo apt -y install linux-kvm
sudo kvm-ok
sudo apt-get install virt-viewer
sudo adduser $(id -un) libvirt
sudo adduser $(id -un) kvm
sudo apt install libvirt-clients
virsh list --all
sudo rmmod kvm
sudo modprobe -a kvm
setfacl -m u:$USER:rw   /dev/kvm
getfacl /dev/kvm
exit 0
