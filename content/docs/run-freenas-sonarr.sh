#!/bin/bash
iocage exec sonarr "pw user add media -c media -u 8675309 -d /nonexistent -s /usr/bin/nologin"
iocage exec sonarr "pw groupmod media -m sonarr"
iocage exec sonarr sysrc 'sonarr_user=media'
iocage exec sonarr "pw user add transmission -c media -u 921 -d /nonexistent -s /usr/bin/nologin"
mkdir -p /usr/local/etc/transmission/home/Downloads/
cd /usr/local/etc/transmission/home/Downloads/
ln -s /media/music music
exit
