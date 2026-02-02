#!/bin/bash
#set -xv

# https://sign13.wordpress.com/setting-up-graylog-in-a-freenas-jail/

# pkg install databases/mongodb textproc/elasticsearch2 graylog

pkg install graylog # graylog-6.1.7
pkg info graylog

# https://github.com/ix-plugin-hub/iocage-plugin-index/blob/master/graylog.json
        "graylog",
        "elasticsearch7",
        "mongodb50",
        "pwgen",
        "p5-Digest-SHA"

# pkg install databases/mongodb50
cd /usr/ports/databases/mongodb50/ && make install clean
pkg install mongodb_exporter
# pkg install databases/mongodb70
pkg install databases/mongodb80
pkg info databases/mongodb80
# pkg install npm
# npm install mongosh
# npx mongosh mongodb://127.0.0.1:27017/
# pkg install textproc/opensearch

service mongod status
cat /etc/rc.conf
cat /usr/local/etc/rc.d/mongod
ls -lrta /var/db/mongodb/mongod.log
# /usr/local/etc/rc.d/mongod start
# limits -C daemon NO su -m mongodb -c 'sh -c "/usr/local/bin/mongod --logpath /var/db/mongodb/mongod.log --logappend --config /usr/local/etc/mongodb.conf --dbpath /var/db/mongodb --fork >/dev/null 2>/dev/null"'
mongod --repair
# ld-elf.so.1: /lib/libcxxrt.so.1: version CXXABI_1.3.11 required by /usr/local/bin/mongod not found
strings  /lib/libcxxrt.so.1 | grep CXXABI
version CXXABI_1.3.11
# https://forum.netgate.com/topic/195706/version-cxxabi_1-3-11-required-by-usr-local-bin-mongo-not-found/3
# Log4j2-TF-1-ConfigurationFileWatcher-2 ERROR Cannot locate file /usr/local/etc/graylog/log4j2.xml java.nio.file.NoSuchFileException: /usr/local/etc/graylog/log4j2.xml
# https://forums.freebsd.org/threads/problem-with-kea-dhcp-server.94643/
freebsd-update fetch install
WARNING: FreeBSD 13.1-RELEASE-p9 HAS PASSED ITS END-OF-LIFE DATE.
# Revert from latest to quarterly
sed -i '' 's/latest/quarterly/g' /etc/pkg/FreeBSD.conf
pkg -d update


########### DOING ##########
freebsd-update upgrade -r 13.5-RELEASE
This kernel will not be updated: you MUST update the kernel manually
before running "/usr/sbin/freebsd-update install"

iocage upgrade -r 13.5-RELEASE graylog

./run-freenas-jail-upgrade.sh

nano /usr/local/etc/graylog/server/log4j2.xml
<Root level="warn">
  <AppenderRef ref="STDOUT"/>
  <AppenderRef ref="graylog-internal-logs"/>
  <AppenderRef ref="FreeBSD-logs"/>
</Root>
ls /usr/local/etc/mongodb.conf

service elasticsearch status

service graylog restart
tail -f /var/log/graylog/server.log

cd /usr/local/etc/graylog/server/
wget https://bababou.albandrieu.com/download/geoip/GeoLite2-ASN_20230131/GeoLite2-ASN.mmdb
wget https://bababou.albandrieu.com/download/geoip/GeoLite2-City_20230131/GeoLite2-City.mmdb
ll /usr/local/etc/graylog/server/GeoLite2-City.mmdb
ll /usr/local/etc/graylog/server/GeoLite2-ASN.mmdb

cat /usr/local/etc/graylog/graylog.conf
# prometheus_exporter_enabled

netstat -an | grep -i listen
27017
9200
9300

# See https://github.com/devopstales/pfsense-graylog
# cp service-names-port-number	/usr/local/etc/graylog/server/

# https://jswheeler.medium.com/logging-pfsense-to-graylog-using-input-extraction-rules-e7dc4972fab0

# CustomLog "|/usr/bin/nc -u 172.17.0.24 12203" graylog_access

graylog_enable: -> YES
elasticsearch_enable: -> YES
mongod_enable: -> YES

echo "http://172.17.0.24:9000/"

exit 0
