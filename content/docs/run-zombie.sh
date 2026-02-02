#!/bin/bash
set -xv

# Find zombie processes

# Too many processes
ps -ef | awk '{ print $8 }' | sort -n | uniq -c | sort -n | tail -5

find /proc -maxdepth 1 -user ubuntu -type d -mmin +200 -exec basename {} \; | xargs ps | grep chromedriver | awk '{ print $1 }'

# Zombie
ps auxwww | grep 'Z'

pstree -p -s  4010714
systemd(1)───php-fpm7.2(3075321)───php-fpm7.2(3075345)───sh(4010714)

# See https://codedrill.in/ubuntu-kill-all-processes-and-reload-php-fpm/

sudo killall -KILL php-fpm7.2
sudo systemctl status php7.2-fpm.service
sudo systemctl reload php7.2-fpm.service

/usr/sbin/php-fpm7.2 --nodaemonize --fpm-config /etc/php/7.2/fpm/php-fpm.conf

/etc/php/7.2/fpm/php-fpm.conf

find /etc/php/7.2 -name '*' -type f | xargs grep max_execution_time
/etc/php/7.2/fpm/php.ini:max_execution_time = 1000

sudo nano /etc/php/7.2/fpm/pool.d/www.conf
request_terminate_timeout = 3000
sudo systemctl reload php7.2-fpm.service

# kill zombie
*/15 * * * * killall /usr/bin/chromedriver


exit 0
