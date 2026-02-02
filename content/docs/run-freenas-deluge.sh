#!/bin/bash
deluge --version
service deluged stop
service deluge_web stop
cd ./usr/local/etc/deluge/
sed -i.bak "/pwd_sha1/d" web.conf
cp /usr/local/lib/python2.7/site-packages/deluge/plugins/Blocklist-1.3-py2.7.egg /usr/local/etc/deluge/plugins
exit 0
