#!/bin/bash
set -xv

#https://community.bose.com/t5/%C3%89couteurs-circum-auraux-et-supra/Noise-Cancelling-Headohones-700-ne-s-allume-plus/td-p/285811

#https://www.bose.fr/fr_fr/contact_us.html
#sleep bud 078052Z83190046AE
#bose NC 700 078702Y93253058AE

# Settings, inside PulseAudio Volume Control
# https://freedesktop.org/software/pulseaudio/pavucontrol/
sudo apt install pavucontrol
pavucontrol
#-> Volume Control -> Configuration -> BOSE NC 700 HP
#--------->>>> Headset HeadUnit (HSP/HFP)

# Micro not working with A2DP

# See https://askubuntu.com/questions/1141226/change-bluetooth-headphones-default-audio-mode-a2dp-sink-vs-hsp-hfp

# NOK
#Bose Store La Défense
#Téléphone : 01 47 96 80 85

# In pulse audio
# "Set as Fallback"

# Fix headset not working
# https://www.maketecheasier.com/fix-no-sound-issue-ubuntu/
# pulseaudio --start

# pacmd list-sink-inputs
alsamixer
alsactl restore

sudo apt-get remove --purge alsa-base
sudo apt-get remove --purge pulseaudio
sudo apt-get install alsa-base
sudo apt-get install pulseaudio pulseaudio-utils
sudo alsa force-reload

# LE Bose NC 700 HP 60:AB:D2:02:27:BD
# Choose Handsfree - Bose NC 700 HP

exit 0
