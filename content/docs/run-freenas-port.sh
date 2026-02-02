#!/bin/bash
portsnap fetch&&  portsnap extract
portsnap fetch update
pkg update -f
/usr/sbin/portsnap fetch
/usr/sbin/portsnap extract
/usr/sbin/portsnap update
pkg version -v
echo "https://www.freshports.org/devel/"
./run-freenas-port-common.sh
./run-freenas-port-security.sh
pkg install ruby
pkg install devel/ruby-gems
pkg install graphviz
-----------------------------------------------------
cd /usr/ports&&  make search name=selenium
cd /usr/ports/www/selenium&&  make install clean
pkg install chromium
pkg install py311-certbot py311-certbot-apache py311-certbot-dns-cloudflare
pkg install git
pkg install node
pkg install npm
pkg install hs-ShellCheck
pkg install perl5
pkg install p5-Locale-libintl
pkg install p5-Locale-gettext
pkg install log4j
pkg upgrade ruby23
pkg install ruby23
pkg install autoconf automake libtool re2c bison pkgconf sqlite3 libxml2
pkg install docker
pkg install webmin
./run-freenas-user.sh
exit 0
