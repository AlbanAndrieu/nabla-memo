#!/bin/bash
set -xv
swapon --show
cat /proc/meminfo
for file in /proc/*/status;do  awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file;done
for file in /proc/*/status;do  awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file;done|   sort -k 2 -n -r|  less
sudo apt-get install smem
exit 0
