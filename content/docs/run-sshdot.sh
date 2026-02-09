#!/bin/bash
set -xv

# https://github.com/PFacheris/sshdot

wget https://raw.githubusercontent.com/pfacheris/sshdot/master/sshdot &&
  chmod +x sshdot &&
  sudo mv sshdot /usr/local/bin #or anywhere else on your PATH

echo "echo welcome" >~/.sshdot

sshdot aandrieu@myserver

exit 0
