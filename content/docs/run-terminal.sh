#!/bin/bash
set -xv

# GNOME Terminal

dconf dump /org/gnome/terminal/ > ~/gterminal.preferences

ll ~/gterminal.preferences

cat ~/gterminal.preferences | dconf load /org/gnome/terminal/legacy/profiles:/

gnome-terminal

exit 0
