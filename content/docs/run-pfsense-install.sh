#!/bin/bash
set -xv
sudo apt install screen putty
sudo putty
/dev/ttyUSB0
115200
sudo screen /dev/ttyUSB0 115200
reset to factory defaults
su - root
usb reset
usb storage
usb start
usb info
fatls usb 0:1
run usbrecovery
setenv bootcmd 'run emmcboot'
saveenv
boot
mmc info
printenv
Welcome to Netgate pfSense Plus 25.07.1-RELEASE
Solaris: WARNING: Pool 'pfSense' has encountered an uncorrectable I/O failure and has been suspended
exit 0
