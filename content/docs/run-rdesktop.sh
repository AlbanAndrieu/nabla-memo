#!/bin/bash
set -xv

sudo apt install rdesktop

#rdpport   = 4390+$uid
#rdesktop-vrdp rav-kworkstation:4393 --clipboard -g 1024x768 -u Administrator -p Kondor_123 -a 16 localhost:$rdpport
rdesktop-vrdp -u Administrator -p Kondor_123 rav-kworkstation:4393

exit 0
