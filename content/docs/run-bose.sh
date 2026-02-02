#!/bin/bash
set -xv
sudo apt install pavucontrol
pavucontrol
alsamixer
alsactl restore
sudo apt-get remove --purge alsa-base
sudo apt-get remove --purge pulseaudio
sudo apt-get install alsa-base
sudo apt-get install pulseaudio pulseaudio-utils
sudo alsa force-reload
exit 0
