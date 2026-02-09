#!/bin/bash
set -xv

cd /usr/local/www/apache24/data

ln -s /media/www/nabla-servers-bower-sample alban
ln -s /media/www/nabla-servers-bower-sample sample
ln -s media/www/nabla-site-apache nabla-site-apache
ln -s nabla-site-apache nabla
ln -s nabla en
ln -s nabla/robots.txt robots.txt
ln -s nabla/sitemap-albandrieu-com.xml sitemap.xml

# Update site #1
cd /usr/local/www/apache24/data/nabla-site-apache
chown -R 33:33 *
chown -R 33:33 .*
# chown 1000:33 .git/COMMIT_EDITMSG
chown -R 1000:33 .git/
pkg install git python
git config --global --add safe.directory /media/www/nabla-site-apache
git config --global http.sslVerify false
git config --global pull.rebase true

# Update site #2
cd /usr/local/www/apache24/data/nabla-site-apache
git pull origin master
git push origin HEAD:master

service apache24 restart

# Check heimdall is UP
echo "http://172.17.0.6/tag/nabla"

# Check apache https is UP
echo "https://172.17.0.34/plop.php"
echo "http://172.17.0.34/plop.php"
echo "http://172.17.0.36/alban/#/"

echo "https://alban.albandrieu.com/nabla/index.html"
# echo "https://alban.albandrieu.com/nabla/index/index.html"
echo "https://nabla.albandrieu.com/nabla/index/index.html"
echo "https://nabla.albandrieu.com/nabla/index/assets/"
echo "http://172.17.0.36/alban/#/"
echo "http://172.17.0.36/nabla/index.html"
echo "http://172.17.0.36:8680/nabla/index/index.html"
echo "https://nabla.albandrieu.com/sample/"
# echo "https://bababou.albandrieu.com/nabla/honeypot/introduction.php"
echo "https://nabla.albandrieu.com/nabla/index/honeypot/index.php"
# https://172.17.0.34/nabla/index/honeypot/
echo "https://nabla.albandrieu.com/nabla/index/honeypot/iatrogenic.php"
echo "https://bababou.albandrieu.com/plop.php"

echo "https://nabla.albandrieu.com/nabla/ciso.html"
echo "http://82.66.4.247:8680/nabla/index.html"

# Even without cloudflare, Haprowy is doing redirect
# http://albandrieu.com/ -> https://albandrieu.com/

# Incognito
echo "http://famp.albandrieu.com:8680/nabla/index.html"
echo "http://albandrieu.com:8680/nabla/index.html"

# Status

echo "https://status.albandrieu.com/"
echo "https://dashboard.uptimerobot.com/monitors/800760290"

# pfsense
echo "https://home.albandrieu.com:10443/"
echo "https://172.17.0.1:10443/"
echo "https://82.66.4.247:10443/"

# freenas
echo "https://freenas.albandrieu.com:7000/"

# github
echo "https://github.albandrieu.com/"
echo "https://github.albandrieu.com/public/#"

# vercel
echo "https://vercel.albandrieu.com/"

pkg upgrade

exit 0
