#!/bin/bash
set -xv
sudo dmesg|  grep -i bluetooth
dmesg|  grep -i bluetooth|  grep -i firmware
lsusb
hcidump
sudo snap remove bluez
sudo apt install bluez bluez-obexd
sudo apt install blueman
blueman-manager
pulseaudio --k
nano ~/.config/pulse/client.conf
bluetoothctl
hcitool scan
pacmd list-modules
pavucontrol
~/.config/pulse
sudo apt install pavumeter paprefs
sudo apt install libspa-0.2-bluetooth
systemctl --user enable pulseaudio
systemctl --user start pulseaudio
exit 0
