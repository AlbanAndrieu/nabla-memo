#!/bin/bash
#set -xv

# ubuntu error messages check
sudo dmesg -wHT

sudo dmesg -T -l emerg,alert,crit,err

#grep EDAC /var/log/messages*
# memory issues
#egrep 'Out|Killed' /var/log/messages*

multitail /var/log/kern.log /var/log/dmesg /var/log/syslog

journalctl -f
journalctl -r

exit 0
