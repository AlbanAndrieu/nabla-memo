#!/bin/bash
set -xv
sudo apt-get install language-pack-en language-pack-en-base language-pack-fr
check-language-support -l fr
sudo dpkg-reconfigure locales
export LC_CTYPE=en_US.UTF-8
sudo nano /etc/default/locale
LANG="en_US.UTF-8"
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="fr_FR.UTF-8"
LC_TIME="fr_FR.UTF-8"
LC_MONETARY="fr_FR.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="fr_FR.UTF-8"
LC_NAME="fr_FR.UTF-8"
LC_ADDRESS="fr_FR.UTF-8"
LC_TELEPHONE="fr_FR.UTF-8"
LC_MEASUREMENT="fr_FR.UTF-8"
LC_IDENTIFICATION="fr_FR.UTF-8"
LC_ALL="en_US.UTF-8"
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
cat /etc/locale.conf
locale-gen en_US.UTF-8
exit 0
