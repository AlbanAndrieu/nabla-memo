#!/bin/bash
set -xv

sudo dpkg --configure -a
sudo snap remove slack

# See https://defectdojo.github.io/django-DefectDojo/integrations/notifications/#notifications
# get the deb package from https://doc.ubuntu-fr.org/slack

sudo apt purge slack

sudo apt remove slack-desktop
sudo dpkg -i slack-desktop-4.47.69-amd64.deb

./run-flatpak.sh

flatpak info --show-permissions  com.slack.Slack

exit 0
