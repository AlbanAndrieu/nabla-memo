#!/bin/bash
set -xv

# See https://emojipedia.org/check-mark-button/
# See https://fonts.google.com/noto

wget https://github.com/joypixels/emojione-assets/releases/download/4.5/emojione-android.ttf

cp ~/Downloads/emojione-android.ttf ~/.local/share/fonts/

ll ~/.local/share/fonts/

fc-cache -v -f

# See https://oorkan.medium.com/emojifying-your-linux-terminal-9a5c1e8f6b3c

#sudo apt install fonts-emojione
#Hit Control-Shift-E, then press Space.

exit 0
