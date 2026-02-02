#!/bin/bash
set -xv
wget https://raw.githubusercontent.com/pfacheris/sshdot/master/sshdot&&chmod +x sshdot&&sudo mv sshdot /usr/local/bin
echo "echo welcome" > ~/.sshdot
sshdot aandrieu@myserver
exit 0
