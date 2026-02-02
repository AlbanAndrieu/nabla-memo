#!/bin/bash
set -xv
sudo apt install rdesktop
rdesktop-vrdp -u Administrator -p Kondor_123 rav-kworkstation:4393
exit 0
