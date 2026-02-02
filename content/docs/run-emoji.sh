#!/bin/bash
set -xv
wget https://github.com/joypixels/emojione-assets/releases/download/4.5/emojione-android.ttf
cp ~/Downloads/emojione-android.ttf ~/.local/share/fonts/
ll ~/.local/share/fonts/
fc-cache -v -f
exit 0
