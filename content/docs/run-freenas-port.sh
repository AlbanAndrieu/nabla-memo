#!/bin/bash
#set -xv

# in the jail
# install port
portsnap fetch && portsnap extract

# upon issue :
# pkg: http://pkg.freebsd.org/FreeBSD:12:amd64/latest/meta.txz: Not Found

# To update ports it's enough just to run
# portsnap fetch extract
# for the first time (yes, it downloads and extracts ~60MB for the first time) and
portsnap fetch update

pkg update -f
/usr/sbin/portsnap fetch
/usr/sbin/portsnap extract
/usr/sbin/portsnap update

# Below give already install package

pkg version -v

echo "https://www.freshports.org/devel/"

./run-freenas-port-common.sh

./run-freenas-port-security.sh

#pkg install sudo

pkg install ruby
pkg install devel/ruby-gems
#pkg_add -v -r gtksourceview

#cd /usr/ports/graphics/graphviz/ && make install clean
pkg install graphviz

-----------------------------------------------------
#shorty error
#http://www.macintom.com/wp/2012/06/13/owncloud-bug-lors-de-lactivation-dune-application-owncloud-ne-fonctionne-plus/
#UPDATE  `oc_appconfig` SET  `configvalue` =  "no" WHERE  `appid` =  "shorty" AND  `configkey` =  "enabled"
#UPDATE  `oc_appconfig` SET  `configvalue` =  "no" WHERE  `appid` =  "music" AND  `configkey` =  "enabled"
#UPDATE  `oc_appconfig` SET  `configvalue` =  "no" WHERE  `appid` =  "internal_bookmarks" AND  `configkey` =  "enabled"
#UPDATE  `oc_appconfig` SET  `configvalue` =  "no" WHERE  `appid` =  "mozilla_sync" AND  `configkey` =  "enabled"

#pkg install selenium
cd /usr/ports && make search name=selenium
cd /usr/ports/www/selenium && make install clean
#/usr/local/www/selenium

#To automate browsers you need one or more of these ports:
#pkg install www/firefox
#pkg install www/chromium

#With one or more of these complementary ports:
#pkg install www/geckodriver
#pkg install x11-servers/xorg-vfbserver
#pkg install x11-fonts/xorg-fonts
#pkg install x11-fonts/webfonts
#pkg install x11/xauth
#pkg install x11/xkeyboard-config
#pkg install x11/xkbcomp
#
#Clients can also be found:
#pkg install www/rubygem-selenium-webdriver
#pkg install www/py-selenium
#pkg install devel/p5-Test-WWW-Selenium
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

#pkg install phantomjs
#cd /usr/ports/lang/phantomjs/ && make install clean
#make install clean
#make ALLOW_UNSUPPORTED_SYSTEM=true DISABLE_VULNERABILITIES=yes install clean > test.log
#make ALLOW_UNSUPPORTED_SYSTEM=true clean install > test.log
#make reinstall

#https://wiki.freebsd.org/Docker
pkg install docker
#pkg install docker-freebsd ca_root_nss

# Install by hand in jail
#cd /usr/ports && make search name=webmin
pkg install webmin

# See https://iocage.readthedocs.io/en/latest/advanced-use.html

./run-freenas-user.sh

exit 0
