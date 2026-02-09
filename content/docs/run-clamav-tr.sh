#!/bin/bash
# Script "ClamAV Temps Réel", par HacKurx
# http://hackurx.wordpress.com
# Licence: GPL v3
# Dépendance: clamav-daemon inotify-tools
# Recommandé pour PC de bureau: libnotify-bin

DOSSIER=$HOME
QUARANTINE=/tmp
LOG=$HOME/.clamavd-tr.log

while :; do

  inotifywait -q -r -e create,modify,move,delete,open,close,access "$DOSSIER" --format '%w%f|%e' | sed --unbuffered 's/|.*//g' |
    while read FICHIER; do
      clamdscan -m -v --fdpass "$FICHIER" --move=$QUARANTINE
      if [ "$?" == "1" ]; then
        echo "$(date) - Malware trouvé dans le fichier '$FICHIER'. Le fichier a été déplacé dans $QUARANTINE." >>$LOG
        echo -e "\033[31mMalware trouvé!!!\033[00m" "Le fichier '$FICHIER' a été déplacé en quarantine."
        if [ -f /usr/bin/notify-send ]; then
          notify-send -u critical "ClamAV Temps Réel" "Malware trouvé!!! Le fichier '$FICHIER' a été déplacé en quarantine."
        fi
      fi
    done
done

exit 0
