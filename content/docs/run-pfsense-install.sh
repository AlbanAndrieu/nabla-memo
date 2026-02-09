#!/bin/bash
set -xv

# Reset using putty and serial
# https://docs.netgate.com/pfsense/en/latest/solutions/sg-2440/connect-to-console.html#putty-in-linux
sudo apt install screen putty
sudo putty
/dev/ttyUSB0
115200
sudo screen /dev/ttyUSB0 115200

reset to factory defaults
su - root

# https://docs.netgate.com/pfsense/en/latest/solutions/sg-1100/reinstall-pfsense.html

usb reset
usb storage
# usb part
usb start
usb info
fatls usb 0:1
run usbrecovery
# setenv bootcmd 'run usbboot'
setenv bootcmd 'run emmcboot'
saveenv

boot

mmc info
printenv

# pfsense cannot open /boot/lua/loader.lua

# console comconsole failed to initialize
# Consoles: EFI console
#     Reading loader env vars from /efi/freebsd/loader.env - 10:14:54 -0300)
# Setting currdev to disk0p2:
# FreeBSD/arm64 EFI loader, Revision 1.1
# (Fri Feb 10 20:26:39 UTC 2023 root@freebsd)
#        L2      800 [MHz]
#    Command line arguments: loader.efi
#    Image base: 0x7000000
#    EFI version: 2.70
#    EFI Firmware: Das U-Boot (rev 0.00)
#    Console: efi,comconsole (0)
#    Load Path: /\armada-3720-sg1100.dtb
#    Load Device: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b)/eMMC(1)/eMMC(0)/HD(2,0x01,0,0x64001,0x1117c)
# Trying ESP: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b)/eMMC(1)/eMMC(0)/HD(2,0x01,0,0x64001,0x1117c)
# Setting currdev to disk0p2:orts 6 Gbps 0x1 impl SATA mode
# Trying: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b)/eMMC(1)/eMMC(0)/HD(1,0x01,0,0x1,0x64000)
# Setting currdev to disk0p1:
# Trying: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b)/eMMC(1)/eMMC(0)/HD(3,0x01,0,0x7517d,0xe1bd03)
# Setting currdev to zfs:pfSense/ROOT/default:tected mx25u3235f with page size 256 Bytes, erase size 64 KiB, total 4 MiB
# ERROR: cannot open /boot/lua/loader.lua: no such file or directory.
# Model: Netgate 1100
# Net:   eth0: neta@30000 [PRIME]

# https://forum.netgate.com/topic/184920/usb-recovery-problems-on-sg1100

# Selected eMMC device: mmcsd0 - ZFS

Welcome to Netgate pfSense Plus 25.07.1-RELEASE
Solaris: WARNING: Pool 'pfSense' has encountered an uncorrectable I/O failure and has been suspended

exit 0
