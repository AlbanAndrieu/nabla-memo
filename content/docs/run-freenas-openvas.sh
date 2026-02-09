#!/bin/bash
#set -xv

# inside clamav jail

pkg update -f

pkg autoremove

pkg install databases/postgresql13-server

# See https://www.freshports.org/security/gvm/
pkg install gvm
# It will install
# pkg install databases/pg-gvm
cd /usr/ports/databases/pg-gvm/ && make install clean
# pkg install postgresql16-client

cd /usr/local/etc/gvm/
echo "[notus-scanner]" >/usr/local/etc/gvm/notus-scanner.toml
echo 'mqtt-broker-address = "localhost"' >>/usr/local/etc/gvm/notus-scanner.toml
echo 'mqtt-broker-port = "1883"' >>/usr/local/etc/gvm/notus-scanner.toml
echo 'products-directory = "/var/lib/notus/products"' >>/usr/local/etc/gvm/notus-scanner.toml
echo 'log-level = "INFO"' >>/usr/local/etc/gvm/notus-scanner.toml

echo "disable-hashsum-verification = false" >>/usr/local/etc/gvm/notus-scanner.toml

pw groupmod redis -M gvm

#pkg install databases/postgresql16-server
pkg install databases/postgresql17-server

./run-freenas-postgres.sh

ls -lrta /usr/local/share/postgresql/extension/

#  su -l postgres
# start a new shell
su postgres
createuser -DRS gvm
createdb -O gvm gvmd
psql gvmd
create role dba with superuser noinherit
grant dba to gvm
SET search_path TO public
DROP EXTENSION IF EXISTS "uuid-ossp"
# CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION "uuid-ossp" SCHEMA public
CREATE EXTENSION IF NOT EXISTS "pgcrypto"
CREATE EXTENSION IF NOT EXISTS "pg-gvm"
SELECT * FROM pg_available_extensions
\q

echo "db_address = /var/run/redis/redis.sock" >/usr/local/etc/openvas/openvas.conf

pw groupmod redis -M gvm

service gvmd stop
service gsad stop

rm /var/lib/gvm/feed-update.lock
su -m gvm -c "greenbone-nvt-sync --version"
# tcptraceroute feed.community.greenbone.net 873
# nc feed.community.greenbone.net 873
# nano /etc/gvm/greenbone-feed-sync.toml

su -m gvm -c "greenbone-nvt-sync"

su -m gvm -c "greenbone-feed-sync --type GVMD_DATA"
su -m gvm -c "greenbone-feed-sync --type SCAP"
su -m gvm -c "greenbone-feed-sync --type CERT"

su -m gvm
/var/lib/gvm/gvmd/gvm-create-functions

# https://greenbone.github.io/docs/latest/22.4/source-build/troubleshooting.html#failed-to-find-port-list-33d0cd82-57c6-11e1-8ed1-406186ea4fc5
find /var/lib/gvm/data-objects/ -name "*33d0cd82-57c6-11e1-8ed1-406186ea4fc5*.xml"
service postgresql start

su -m gvm -c "gvmd --migrate"
service gvmd start
su -m gvm -c "gvmd --rebuild-gvmd-data=all"

su -m gvm -c "greenbone-feed-sync --type nvt"

su -m gvm -c "gvmd --create-user=nabla"
su -m gvm -c "gvmd --user=nabla --new-password=XXX"

su -m gvm -c "gvmd --get-users --verbose"

su -m gvm -c "gvmd --modify-setting 78eceaec-3385-11ea-b237-28d24461215b --value 26c2f14e-9ff9-4e8a-9eaf-bdb665ffb0b2"

service ospd_openvas start
su -m gvm -c "gvmd --get-scanners"

cat /var/log/gvm/ospd-openvas.log

pkg install openvas # only the scanner

# pdf
pkg install tex-xetex

exit 0
