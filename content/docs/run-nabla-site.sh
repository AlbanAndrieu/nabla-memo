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
cd /usr/local/www/apache24/data/nabla-site-apache
chown -R 33:33 *
chown -R 33:33 .*
chown -R 1000:33 .git/
pkg install git python
git config --global --add safe.directory /media/www/nabla-site-apache
git config --global http.sslVerify false
git config --global pull.rebase true
cd /usr/local/www/apache24/data/nabla-site-apache
git pull origin master
git push origin HEAD:master
service apache24 restart
echo "http://172.17.0.6/tag/nabla"
echo "https://172.17.0.34/plop.php"
echo "http://172.17.0.34/plop.php"
echo "http://172.17.0.36/alban/#/"
echo "https://alban.albandrieu.com/nabla/index.html"
echo "https://nabla.albandrieu.com/nabla/index/index.html"
echo "https://nabla.albandrieu.com/nabla/index/assets/"
echo "http://172.17.0.36/alban/#/"
echo "http://172.17.0.36/nabla/index.html"
echo "http://172.17.0.36:8680/nabla/index/index.html"
echo "https://nabla.albandrieu.com/sample/"
echo "https://nabla.albandrieu.com/nabla/index/honeypot/index.php"
echo "https://nabla.albandrieu.com/nabla/index/honeypot/iatrogenic.php"
echo "https://bababou.albandrieu.com/plop.php"
echo "https://nabla.albandrieu.com/nabla/ciso.html"
echo "http://82.66.4.247:8680/nabla/index.html"
echo "http://famp.albandrieu.com:8680/nabla/index.html"
echo "http://albandrieu.com:8680/nabla/index.html"
echo "https://status.albandrieu.com/"
echo "https://dashboard.uptimerobot.com/monitors/800760290"
echo "https://home.albandrieu.com:10443/"
echo "https://172.17.0.1:10443/"
echo "https://82.66.4.247:10443/"
echo "https://freenas.albandrieu.com:7000/"
echo "https://github.albandrieu.com/"
echo "https://github.albandrieu.com/public/#"
echo "https://vercel.albandrieu.com/"
pkg upgrade
exit 0
