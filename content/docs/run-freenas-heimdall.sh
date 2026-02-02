#!/bin/bash
set -xv
find .. -name 'HeimdallExport*'
cd /usr/local/www/heimdall
git config --global --add safe.directory /usr/local/www/heimdall
php --version
pkg install php82-zip php-composer
pkg install nginx
pkg install redis
ll /usr/local/etc/redis.conf
sysrc redis_enable="YES"
cat /etc/rc.conf
echo https://github.com/linuxserver/Heimdall
git fetch --tags
git tag -l
git checkout tags/v2.6.1
echo https://172.17.0.6/
ls -lrta ./database/app.sqlite
ls -lrta ./storage/app/public
ls -lrta /var/backups/heimdall-data/public/
cd /usr/local/www/heimdall
cp -af /var/backups/heimdall-data/app.sqlite ./database/app.sqlite
cp .env.example .env
nano /usr/local/etc/php-fpm.conf
nano /usr/local/etc/php-fpm.d/www.conf
service redis restart
service php_fpm restart
service nginx restart
/usr/local/etc/heimdall/
pkg install security/py-fail2ban
pkg install php82 php82-composer
pkg install php82-filter php82-curl php82-pdo php82-pdo_sqlite php82-session php82-simplexml php82-sqlite3 php82-zip git ca_root_nss
pkg install php82-tokenizer php82-dom pkg php82-tokenizer php82-sodium php82-fileinfo php82-xml
composer install
less /var/log/nginx/error.log
/usr/local/www/heimdall/public
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
