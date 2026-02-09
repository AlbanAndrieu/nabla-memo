#!/bin/bash
set -xv

# linux printer driver brother dcp l8410cdw
# https://support.brother.com/g/b/downloadtop.aspx?c=fr&lang=fr&prod=dcpl8410cdw_eu
# dcpl8410cdwlpr-1.5.0-0.i386.deb

# sudo apt install gss-ntlmssp libusb-0.1-4

/etc/init.d/cups restart

sudo systemctl enable cups.service

echo 192.168.3.196

exit 0
