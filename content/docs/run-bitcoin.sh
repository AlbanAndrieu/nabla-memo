#!/bin/bash
#set -xv

WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ./run-bitcoin-install.sh

echo -e "${green} Starting bitcoin QT ${NC}"

/usr/local/bin/bitcoin-qt -disablewallet -listenonion -listen=1 -prune=0 # -debug=tor -proxy=127.0.0.1:9051

grep "tor: Successfully connected" /media/bitcoin/.bitcoin/debug.log

echo -e "${magenta} journalctl -f | grep tor -i ${NC}"

echo "tail -f /media/bitcoin/.bitcoin/debug.log"

systemctl --user status bitcoin-qt.service
systemctl --user status bitcoin-qt.timer

exit 0
