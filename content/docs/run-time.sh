#!/bin/bash
set -xv

# Wrong time in dmesg
# https://serverfault.com/questions/576139/dmesg-time-vs-system-time-time-isnt-correct
dmesg -T

sudo apt install util-linux-extra
sudo hwclock --show

journalctl -k
journalctl --dmesg

exit 0
