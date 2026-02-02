#!/bin/bash
#set -xv

# Apache jail updated after removing NAT
# Disable DHCP Autoconfigure IPv4
# Change DHCP not running for IPv4:
# Change from 172.16.0.26 to  172.16.0.27

portsnap fetch update

./run-freenas-iocage.sh

# https://www.truenas.com/community/threads/cant-update-pkg-in-iocage.101780/

jls

iocage upgrade -r 13.1 <jailname>
iocage upgrade -r 13.1-RELEASE-p9 jenkins-lts
# Branch 13.1-RELEASE does not exist at https://github.com/freenas/iocage-plugin-jenkins-lts.git!
# start the jail and after it works
 # upgraded to 13.2-RELEASE-p11

iocage upgrade 13.2-RELEASE-p11 famp
# https://github.com/fulder/iocage-plugin-famp

iocage upgrade -r 13.2-RELEASE apache # NOK fail
iocage update apache
iocage upgrade -r 13.2-RELEASE bind # NOK fail
iocage update bind # NOK fail
# AttributeError: 'list' object has no attribute 'decode'
iocage upgrade -r 13.2-RELEASE clamav
iocage upgrade -r 13.2-RELEASE heimdall
iocage upgrade -r 13.2-RELEASE grafana  # NOK fail
iocage update grafana

iocage upgrade -r 13.2-RELEASE graylog
###### DOING ######
iocage fetch
# Fetching: 13.5-RELEASE
iocage upgrade -r 13.4-RELEASE paperless

iocage upgrade -r 13.2-RELEASE nexus # ok
iocage upgrade nexus # NOK fail
iocage update nexus # NOK fail
iocage upgrade vault # OK
iocage upgrade clamav
# iocage update vault


./run-freenas-jail-upgrade.sh

jexec 22 sh

cat /etc/pkg/FreeBSD.conf

# https://pkg.opnsense.org/FreeBSD:12:amd64/21.7/latest/

# pkg-static install -f pkg
freebsd-version -k
freebsd-version -u
# root shell
13.1-RELEASE-p9
# redis
13.2-RELEASE-p12
uname -mrs
FreeBSD 13.1-RELEASE-p9 amd64
# famp
13.2-RELEASE-p12

uname -a
# if version do not match
# Ports Collection support for your FreeBSD version has ended, and no ports are guaranteed

# inside graylog jail
uname -a
# FreeBSD graylog 13.1-RELEASE-p9

#rm -rf /var/db/freebsd-update/
#mkdir /var/db/freebsd-update
freebsd-update upgrade -r 13.2-RELEASE
# targeting 13.2-RELEASE-p12
uname -mrs
freebsd-update install
freebsd-update fetch install
# WARNING: FreeBSD 13.1-RELEASE-p9 HAS PASSED ITS END-OF-LIFE DATE.

# https://freenas.albandrieu.com:7000/ui/jails/shell/jenkins-lts

cp /etc/pkg/FreeBSD.conf /etc/pkg/FreeBSD.conf.bak
sed -i '' 's/quarterly/latest/g' /etc/pkg/FreeBSD.conf

pkg version -v
pkg -d update

IGNORE_OSVERSION=yes
pkg update -f
pkg install nginx # heimdall

# https://www.freshports.org/devel/

exit 0
