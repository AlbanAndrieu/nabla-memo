#!/bin/bash
set -xv
sudo apt install cups
sudo apt-get remove pips-snx100:i386
ls -l /var/lib/dpkg/info|  grep pips-snx100
sudo mv /var/lib/dpkg/info/pips-snx100.* /tmp/
sudo apt --fix-broken install
sudo /usr/local/EPAva/printer/snx100/uninstall-snx100.sh
sudo ./pips-snx100-ubuntu8.04-3.5.0-CG.install
ls -lrta /usr/local/EPAva/printer/snx100/
lpstat -p -d
/etc/init.d/cups restart
lsusb|  grep -i epson
sudo apt-get install escputil mtink
ls /dev/usb/lp2
sudo escputil -i -r /dev/usb/lp2
sudo apt-get install libcups2-dev
sudo apt-get install lsb-base printer-driver-escpr
sudo gtklp
sudo usermod -a -G lpadmin albandrieu
sudo lpadmin -p sx105 -E -v usb://EPSON/Stylus%20SX100?serial=KQHZ592124&
interface=1 -m /usr/local/EPAva/printer/snx100/ekssx100.ppd
geany /usr/share/doc/pips-core-3.5.0/UsersManual.en.txt
ll /etc/cups/ppd/Stylus-SX100.ppd
printer-driver-hpijs printer-driver-gutenprint
exit 0
