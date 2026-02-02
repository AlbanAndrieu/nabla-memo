#!/bin/bash
set -xv
iocage exec transmission "pw user add media -c media -u 8675309 -d /nonexistent -s /usr/bin/nologin"
iocage exec transmission "pw groupmod media -m transmission"
iocage exec transmission chown -R media:media /media
iocage exec transmission sysrc 'transmission_user=media'
iocage exec sonarr "pw user add media -c media -u 8675309 -d /nonexistent -s /usr/bin/nologin"
iocage exec sonarr "pw groupmod media -m transmission"
cd /mnt/dpool/iocage/jails/transmission/root/usr/local/etc/transmission/home/
ln -s /media/download Downloads
ln -s /media/torrentfile/ torrents
http://192.168.0.01:9091/
http://albandrieu.com:9091/transmission/web/
cd /usr/pbi/transmission-amd64/etc/transmission/home/
edit /usr/pbi/transmission-amd64/etc/transmission/home/settings.json
cd /usr/local/etc/transmission/home/
cd /mnt/dpool/www/apache24/data/nabla-site-apache/scripts
./run-wicked.sh
cp /mnt/dpool/www/apache24/data/nabla-site-apache/scripts/out-transmission-wickedlist.txt /mnt/dpool/iocage/jails/transmission/root/usr/local/etc/transmission/home/blocklists/
cd /usr/local/etc/transmission/home/blocklists
service transmission restart
exit 0
