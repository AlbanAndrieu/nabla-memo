#!/bin/bash
set -xv

# See https://cloudinit.readthedocs.io/en/latest/tutorial/qemu.html

sudo apt install qemu-system-x86
sudo apt install cloud-init

cloud-init status --wait

less /var/log/cloud-init-output.log
ls -lrta /etc/cloud/cloud.cfg.d/

exit 0
