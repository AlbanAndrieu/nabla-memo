#!/bin/bash
set -xv
dmesg -T
sudo apt install util-linux-extra
sudo hwclock --show
journalctl -k
journalctl --dmesg
exit 0
