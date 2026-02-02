#!/bin/bash
#set -xv

# https://www.freshports.org/devel/php-composer
pkg update -f

pkg autoremove

pkg search php82

pkg install php82
pkg install mod_php82
# 8.2.27
# for upgrade
# pkg install php82 php82-mysqli mod_php82
# pkg install php82-mysqli php82-json php82-mbstring php82-session php82-iconv php82-brotli
pkg upgrade -y

pkg install php82-mysqli php82-session php82-iconv php82-brotli

pkg install php82-composer
# php82-hash php82-json php82-openssl
pkg install php82-filter php82-curl php82-pdo php82-pdo_sqlite php82-session php82-simplexml php82-sqlite3 php82-zip git ca_root_nss

#  Call to undefined function Hp\\gzdecode
# PHP Fatal error:  Uncaught Error: Call to undefined function Hp\\gzdecode() in /media/www/nabla-site-apache/index/honeypot/introduction.php
#NOK pkg install p5-CGI-Compress-Gzip gzip php82-zlib

pkg install php82-extensions

apachectl configtest
apachectl restart

composer install

# portsnap fetch extract update
cd /usr/ports/

service php-fpm restart
service nginx restart

ls /usr/local/etc/php.conf

nano /usr/local/etc/apache24/Includes/php.conf

sudo nano /usr/local/www/apache24/data/plop.php

<?php phpinfo(); ?>

http://10.20.0.24:8780/plop.php

---------------
nano /usr/local/etc/php.ini
extension=mysqli.so
extension=mbstring.so

extension=session.so
extension=json.so
extension=iconv.so

# Check
apachectl -M

sysrc php_fpm_enable="YES"

edit /usr/local/etc/apache24/modules.d/030_php-fpm.conf
<IfModule proxy_fcgi_module>
	<IfModule dir_module>
		DirectoryIndex index.php
	</IfModule>
	<FilesMatch "\.(php|phtml|inc)$">
		SetHandler "proxy:fcgi://127.0.0.1:9000"
	</FilesMatch>
</IfModule>
nl -ba /usr/local/etc/apache24/httpd.conf | grep mod_proxy.so
sudo vi +130 /usr/local/etc/apache24/httpd.conf
nl -ba /usr/local/etc/apache24/httpd.conf | grep mod_proxy_fcgi.so
sudo vi +134 /usr/local/etc/apache24/httpd.conf

sudo service php-fpm start
tail -f /var/log/php-fpm.log

service php-fpm status

#mod_expires
#mod_vhost_alias.so
#mod_rewrite.so
#mod_actions.so

#edit /usr/local/etc/php-fpm.d/www.conf
edit /usr/local/etc/apache24/Includes/php.conf

nano /usr/local/etc/apache24/httpd.conf

service php-fpm onestart
tail -f /var/log/php-fpm.log
tail -f /var/log/albandrieu.com-error_log

service apache24 restart

See https://albandrieu.com/plop.php

pkg info -l php82
# pkg info -l php74

php -v

php -m

# The mpm module (prefork.c) is not supported by mod_http2
nano /usr/local/etc/apache24/httpd.conf
LoadModule http2_module libexec/apache24/mod_http2.so
# echo Protocols h2 h2c http/1.1 > /usr/local/etc/apache24/Includes/http2.conf
service apache24 restart
curl -I --http2 https://albandrieu.com

apachectl configtest

# because search permissions are missing on a component of the path
chmod +x /usr/local/www/apache24/data/nabla/index/honeypot/
find /media/www/nabla-site-apache/index -type d -ls

exit 0
