#!/bin/bash
pip install --upgrade pip
pip list --outdated --format=freeze
/usr/local/bin/freenas-update check
jls
jexec 48 /bin/tcsh
./run-freenas-port.sh
ls /mnt/dpool/jails/
ls /mnt/dpool/iocage/jails
exit 0
