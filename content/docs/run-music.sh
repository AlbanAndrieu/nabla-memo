#!/bin/bash
set -xv
sudo apt-get install rhythmbox-plugin-alternative-toolbar
sudo add-apt-repository ppa:fossfreedom/rhythmbox-plugins
sudo apt search rhythmbox
sudo apt-get install rhythmbox-plugin-playlist-import-export
sudo apt-get install rhythmbox-plugin-llyrics rhythmbox-plugin-android-remote
sudo apt-get install rhythmbox-plugin-rating-filters rhythmbox-plugin-tray-icon
exit 0
