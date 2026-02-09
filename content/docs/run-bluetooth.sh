#!/bin/bash
set -xv

# USB receiver TP-LINK UB4000 is working with Ubuntu 20

# See https://www.nielsvandermolen.com/bluetooth-headphones-ubuntu/

sudo dmesg | grep -i bluetooth               # Shows all Bluetooth driver info
dmesg | grep -i bluetooth | grep -i firmware # Shows Bluetooth firmware issues
lsusb                                        # Displays hardware connected to the USB ports

#0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
#https://linux-hardware.org/index.php?id=usb:0a12-0001
hcidump

# Use apt instead of snap for bluez
#sudo snap install bluez
sudo snap remove bluez
sudo apt install bluez bluez-obexd

sudo apt install blueman
blueman-manager

# Then aukey br-c1 is detected
# Connected to phono on yamaha

# See https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Bluetooth/
pulseaudio --k

# See https://bugs.freedesktop.org/show_bug.cgi?id=93898
nano ~/.config/pulse/client.conf
#Create '~/.config/pulse/client.conf' with the following line:
#autospawn = no

#sudo apt-get install git linux-headers-generic build-essential dkms
#lsmod | grep bluetooth
bluetoothctl

# See https://doc.ubuntu-fr.org/bluetooth
hcitool scan

# Config bluetooth aukey
pacmd list-modules
#module-device-restore
#module-card-restore

pavucontrol

# Settinges saved into
~/.config/pulse

sudo apt install pavumeter paprefs
sudo apt install libspa-0.2-bluetooth

# br-connection-profile-unavailable
systemctl --user enable pulseaudio
systemctl --user start pulseaudio

# LE Bose NC 700 HP 60:AB:D2:02:27:BD
# Choose Handsfree - Bose NC 700 HP

exit 0
