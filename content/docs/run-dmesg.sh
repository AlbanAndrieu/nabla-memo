#!/bin/bash
sudo dmesg -wHT
sudo dmesg -T -l emerg,alert,crit,err
multitail /var/log/kern.log /var/log/dmesg /var/log/syslog
journalctl -f
journalctl -r
exit 0
