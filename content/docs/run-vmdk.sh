#!/bin/bash
set -xv
sudo apt-get install qemu-utils -y
modinfo nbd
sudo modprobe nbd max-part=4
qemu-nbd -r -c /dev/nbd0 Windows\ Server\ 2016-0000.2.vmdk
exit 0
