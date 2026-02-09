#!/bin/bash
set -xv

find .. -name 'HeimdallExport*'

# mkdir /data/heimdall
# sudo docker run --name=heimdall -d -v /data/heimdall:/config -e PGID=2000 -e PUID=1000 -p 8080:80 -p 8443:443 linuxserver/heimdall

# Using freenas
# https://github.com/jsegaert/iocage-plugin-heimdall
# See http://192.168.1.21

cd /usr/local/www/heimdall
git config --global --add safe.directory /usr/local/www/heimdall

php --version
# 8.0.30

# See https://github.com/jsegaert/iocage-plugin-heimdall/blob/master/post_install.sh

pkg install php82-zip php-composer
pkg install nginx
pkg install redis
ll /usr/local/etc/redis.conf
sysrc redis_enable="YES"
cat /etc/rc.conf

echo https://github.com/linuxserver/Heimdall
git fetch --tags
git tag -l
# git checkout tags/v2.4.0
# git checkout tags/v2.5.7
# git checkout tags/v2.2.2
git checkout tags/v2.6.1 #  Your Composer dependencies require a PHP version ">= 8.2.0"

echo https://172.17.0.6/

# Class "Illuminate\Notifications\NexmoChannelServiceProvider" not found
# https://github.com/jsegaert/iocage-plugin-heimdall/issues/4

ls -lrta ./database/app.sqlite
ls -lrta ./storage/app/public
ls -lrta /var/backups/heimdall-data/public/

cd /usr/local/www/heimdall
cp -af /var/backups/heimdall-data/app.sqlite ./database/app.sqlite

cp .env.example .env

nano /usr/local/etc/php-fpm.conf
# [pool www] server reached pm.max_children setting (5), consider raising it
nano /usr/local/etc/php-fpm.d/www.conf
# pm.max_children = 10

# When down
service redis restart
service php_fpm restart

service nginx restart

/usr/local/etc/heimdall/

# See http://172.17.0.110

pkg install security/py-fail2ban
# FreeBSD 13.1

# https://www.freshports.org/devel/php-composer
pkg install php82 php82-composer
pkg install php82-filter php82-curl php82-pdo php82-pdo_sqlite php82-session php82-simplexml php82-sqlite3 php82-zip git ca_root_nss
pkg install php82-tokenizer php82-dom pkg php82-tokenizer php82-sodium php82-fileinfo php82-xml
composer install

less /var/log/nginx/error.log
/usr/local/www/heimdall/public # nano .htaccess
chown -R www:www .

pkg install php-fpm_exporter node_exporter
sysrc redis_exporter_enable=YES
service redis_exporter start
sysrc php-fpm_exporter=YES
service php-fpm_exporter start

pkg install redis_exporter
sysrc redis_exporter_enable=YES
service redis_exporter start

exit 0
