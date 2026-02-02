#!/bin/bash
set -xv

./run-freenas-port-common.sh
./run-freenas-port-security.sh

pkg install nano bash git
#bash_completion
ln -s /usr/local/bin/bash /bin/bash

###################################

#install lamp
#https://www.digitalocean.com/community/tutorials/how-to-install-an-apache-mysql-and-php-famp-stack-on-freebsd-10-1

#install apache

#https://forums.freenas.org/index.php?threads/howto-install-apache-under-jail-with-freenas-8-3.10594/

pkg update
pkg upgrade -y
pkg install apache24
# https://www.freshports.org/search.php?query=apachetop&search=go&num=10&stype=name&method=match&deleted=excludedeleted&start=1&casesensitivity=caseinsensitive
cd /usr/ports/sysutils/apachetop/
make install clean
pkg install apachetop
#cd /usr/ports/www/apache24
cat /usr/local/etc/apache24/httpd.conf | grep Listen
echo 'apache24_enable="YES"' >> /etc/rc.conf

#as non jail
#start apache
/usr/local/etc/rc.d/apache24 start
service apache24 restart

#See http://192.168.1.61/

#####################

./run-freenas-php.sh

#####################

#NOK pkg install databases/mysql80-server

#Installed packages to be REMOVED:
#	cdash: 2.2.3_2
#	mysql57-client: 5.7.33

#pkg install devel/cdash
#Moved:	devel/llvm90
cd /usr/ports/devel/cdash && make install clean

pkg install mysql57-server

sudo sysrc mysql_enable=yes
service mysql-server start
mysql_secure_installation

#https://www.ostechnix.com/install-phpmyadmin-apache-nginx-freebsd-10-2/
pkg install phpMyAdmin5-php82-5.1.0
pkg remove php74-mysqli php74-mbstring

To make phpMyAdmin available through your web site, I suggest
that you add something like the following to httpd.conf:

Alias /phpmyadmin/ "/usr/local/www/phpMyAdmin/"

<Directory "/usr/local/www/phpMyAdmin/">
    Options None
    AllowOverride Limit

    Require local
    Require host .albandrieu.com
</Directory>

http://192.168.1.61/phpMyAdmin/

#################

# In webmin
#from "/var/db/mysql/my.cnf" to "/usr/local/etc/mysql/my.cnf"

#Access denied for user ''@'localhost' to database 'cdash'

mysql -u root -p
<HERE YOU TYPE YOUR MYSQL ROOT PASSWORD>

create database cdash;
create user 'cdash'@'localhost' identified by 'microsoft';
grant all privileges on cdash.* to 'cdash'@'localhost' with grant option;
FLUSH PRIVILEGES;
quit;

cd /usr/local/www/CDash

less /var/log/httpd-albandrieu.com-error.log
[Thu May 13 02:36:31.531739 2021] [php7:error] [pid 41234] [client 192.168.132.57:60700] script '/usr/local/www/CDash/version.php' not found or unable to stat
[Thu May 13 02:36:33.910827 2021] [php7:error] [pid 41234] [client 192.168.132.57:60700] PHP Fatal error:  Uncaught Error: Call to undefined function mysql_connect()
in /usr/local/www/CDash/cdash/pdocore.php:48\nStack trace:\n
#0 /usr/local/www/CDash/cdash/pdocore.php(441): pdo_connect('localhost', 'root', 'microsoft')\n
#1 /usr/local/www/CDash/cdash/log.php(19): require_once('/usr/local/www/...')\n
#2 /usr/local/www/CDash/cdash/pdo.php(18): require_once('/usr/local/www/...')\n
#3/usr/local/www/CDash/index.php(19): require_once('/usr/local/www/...')\n
#4 {main}\n  thrown in /usr/local/www/CDash/cdash/pdocore.php on line 48
/var/log/httpd-albandrieu.com-error.log (END)
$CDASH_FORWARDING_IP='192.%'; // should be an SQL format

nano /usr/local/etc/apache24/httpd.conf

<IfModule dir_module>
DirectoryIndex index.php index.html
</IfModule>

#At the end
<FilesMatch "\.php$">
      application/x-httpd-php
</FilesMatch>
<FilesMatch "\.phps$">
    SetHandler application/x-httpd-php-source
</FilesMatch>

#DocumentRoot "/usr/local/www/apache24/data"
cd /usr/local/www/apache24/data

#https://mujahidjaleel.blogspot.fr/2016/10/how-to-install-apache-v24-webserver-in.html

# See https://certbot.eff.org/lets-encrypt/freebsd-apache

#pkg remove -y py27-certbot
cd /usr/ports/security/py-certbot && make install clean

#The certbot plugins to support apache and nginx certificate installation
#will be made available in the following ports:
#
# * Apache plugin: security/py-certbot-apache
# * Nginx plugin: security/py-certbot-nginx
#
#In order to automatically renew the certificates, add this line to
#/etc/periodic.conf:
#
#    weekly_certbot_enable="YES"

certbot certonly
#certbot --apache -d albandrieu.com -d www.albandrieu.com
certbot renew
# AND restart apache

#INPUT
#2
#albandrieu.com,nabla.albandrieu.com,home.albandrieu.com,cv.albandrieu.com,sample.albandrieu.com
#1
#/usr/local/www/apache24/data

#NOK /usr/local/www/apache24/data/sample
#NOK /usr/local/www/apache24/data/alban
#NOK /usr/local/www/apache24/data/bababou

#TODO freenas.nabla.mobi,jenkins.nabla.mobi

less /usr/local/etc/letsencrypt/renewal/albandrieu.com.conf

cert = /usr/local/etc/letsencrypt/live/albandrieu.com-0001/cert.pem
privkey = /usr/local/etc/letsencrypt/live/albandrieu.com-0001/privkey.pem
chain = /usr/local/etc/letsencrypt/live/albandrieu.com-0001/chain.pem
fullchain = /usr/local/etc/letsencrypt/live/albandrieu.com-0001/fullchain.pem

nano /usr/local/etc/apache24/httpd.conf
Listen 80
Listen 8680

grep -n 'mod_ssl.so' /usr/local/etc/apache24/httpd.conf
# Do not uncomment below
#Include etc/apache24/extra/httpd-ssl.conf

# certbot will add at the end
Include etc/apache24/Includes/*.conf

<IfModule mod_ssl.c>
Listen 443
</IfModule>
Include /usr/local/etc/apache24/extra/httpd-vhosts-le-ssl.conf

#certbot certonly --standalone -d albandrieu.com

ServerName www.albandrieu.com
ServerAdmin alban.andrieu@free.fr
ServerAlias www.albandrieu.com

# Virtual hosts
Include etc/apache24/extra/httpd-vhosts.conf

nano /usr/local/etc/apache24/extra/httpd-vhosts.conf


# Cloudflare
# https://developers.cloudflare.com/support/troubleshooting/restoring-visitor-ips/restoring-original-visitor-ips/
# https://www.cloudflare.com/fr-fr/ips/

nano /usr/local/etc/apache24/httpd.conf

# Libre à vous de remplacer par X-Real-IP
# RemoteIPHeader X-Forwarded-For

# ici les adresses distantes auxquelles on fait confiance pour présenter une valeur RemoteIPHeader
# RemoteIPTrustedProxy 127.0.0.1 ::1

# SEE : /var/www/nabla-site-apache/etc/apache24/extra

    RemoteIPHeader X-Forwarded-For
    RemoteIPTrustedProxy 192.168.1.10 10.10.0.1 172.17.0.106 172.17.0.34 82.66.4.247

    LogFormat "{ \"version\": \"1.1\", \"host\": \"%V\", \"short_message\": \"%r\", \"timestamp\": %{%s}t, \"level\": 6, \"_user_agent\": \"%{User-Agent}i\", \"_source_ip\": \"%{X-Forwarded-For}i\", \"_duration_usec\": %D, \"_duration_sec\": %T, \"_request_size_byte\": %O, \"_http_status_orig\": %s, \"_http_status\": %>s, \"_http_request_path\": \"%U\", \"_http_request\": \"%U%q\", \"_http_method\": \"%m\", \"_http_referer\": \"%{Referer}i\", \"_from_apache\": \"true\" }" graylog_access
    LogFormat "{ \"timestamp\": \"%t\", \"service_name\": \"famp\", \"trace_id\": \"%{X-Trace-ID}i\", \"level\": \"INFO\", \"client_ip\": \"%a\", \"nabla_client_ip\": \"%{nabla-client-ip}i\", \"http_endpoint\": \"%U\", \"http_request\": \"%U%q\", \"http_method\": \"%m\", \"http_referer\": \"%{Referer}i\", \"user_agent\": \"%{User-Agent}i\", \"CF-Ray\": \"%{CF-Ray}i\", \"Cf-Connecting-Ip\": \"%{Cf-Connecting-Ip}i\", \"Cf-Pseudo-Ipv4\": \"%{Cf-Pseudo-Ipv4}i\", \"duration\": %{ms}T, \"http_status_orig\": %s, \"http_status\": %>s, \"request_size_byte\": %O }" nabla_stdout
    ErrorLogFormat "{ \"timestamp\": \"%{%Y-%m-%d %T}t.%{usec_frac}t\", \"service_name\": \"famp\", \"trace_id\": \"%{X-Trace-ID}i\", \"level\": \"%l\", \"pid\": %P, \"apr_os_error_state\": \"%E\", \"src_file\": \"%F\", \"client_ip\": \"%a\", \"nabla_client_ip\": \"%{nabla-client-ip}i\", \"message\": \"%M\" }"

    # ErrorLog /dev/stderr
    # CustomLog /dev/stdout combined
    # CustomLog "|/usr/bin/nc -u 172.17.0.24 12203" graylog_access
    CustomLog "|/usr/bin/nc -u 172.17.0.57 12203" graylog_access

<IfModule mod_ssl.c>
    Listen 443
</IfModule>

Include /usr/local/etc/apache24/extra/httpd-vhosts-le-ssl.conf
ServerTokens ProductOnly

service apache24 restart

# https://community.graylog.org/t/step-8-confirm-that-your-data-arrives-and-is-stored/20895/5

# on graylog test
nc -lvu 12203

logger --tcp --server 10.20.0.24 -P 12203 --rfc5424=notq -p user.notice "Test message"
echo -n '{ "version": "1.1", "host": "example.org", "short_message": "A short message", "level": 5, "_some_info": "foo" }' | nc -u 10.20.0.24 12203

nano /usr/local/etc/apache24/extra/httpd-ssl.conf

ServerName www.albandrieu.com:443
ServerAdmin alban.andrieu@free.fr

# Disable line 92 SSLSessionCache

SSLEngine On
SSLCertificateFile "/usr/local/etc/letsencrypt/live/albandrieu.com-0001/cert.pem"
SSLCertificateKeyFile "/usr/local/etc/letsencrypt/live/albandrieu.com-0001/privkey.pem"

openssl s_client -connect localhost:443

service apache24 restart

nano /usr/local/etc/apache24/extra/httpd-vhosts-le-ssl.conf

apachectl configtest
service apache24 restart
# /usr/local/etc/rc.d/apache24 restart

ll /usr/local/etc/letsencrypt/live/albandrieu.com/chain.pem

# ADD
Protocols h2 http/1.1

service apache24 restart

tail -f /var/log/httpd-error.log

http://10.0.0.24:8680/index.pl
http://10.0.0.24:8680/index.cgi

cd /usr/local/www/apache24/data/.well-known/acme-challenge
watch -n 0.1 ls -lRa

pkg install security/py-fail2ban
# pkg install py39-fail2ban
pkg install webalizer
pkg install awstats
pkg install logrotate

# https://192.168.1.61:10000/webalizer/view_log.cgi/%252Fvar%252Flog%252Fhttpd%252Dalbandrieu%252Ecom%252Daccess%252Elog/index.html?xnavigation=1

#See run-awstats.sh

-----------------------------

run-freenas-jenkins.sh

-----------------------------

apachectl graceful

./run-freenas-jenkins-package.sh

# iocage

iocage exec apache sed -i '' -e 's?listen = 127.0.0.1:9000?listen = /var/run/php-fpm.sock?g' /usr/local/etc/php-fpm.d/www.conf
iocage exec apache sed -i '' -e 's/;listen.owner = www/listen.owner = www/g' /usr/local/etc/php-fpm.d/www.conf
iocage exec apache sed -i '' -e 's/;listen.group = www/listen.group = www/g' /usr/local/etc/php-fpm.d/www.conf
iocage exec apache sed -i '' -e 's/;listen.mode = 0660/listen.mode = 0600/g' /usr/local/etc/php-fpm.d/www.conf
iocage exec apache cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
iocage exec apache sed -i '' -e 's?;date.timezone =?date.timezone = "Universal"?g' /usr/local/etc/php.ini
iocage exec apache sed -i '' -e 's?;cgi.fix_pathinfo=1?cgi.fix_pathinfo=0?g' /usr/local/etc/php.ini

edit /mnt/dpool/iocage/jails/organizr/root/usr/local/etc/nginx/

# mounting

/mnt/dpool/www/apache24/
/mnt/dpool/iocage/jails/famp/root/usr/local/www/apache24-backup
/mnt/dpool/www/apache24/data
/mnt/dpool/iocage/jails/famp/root/usr/local/www/apache24/data
/mnt/dpool/www/bababou
/mnt/dpool/iocage/jails/famp/root/media/www/bababou
/mnt/dpool/www/nabla-servers-bower-sample
/mnt/dpool/iocage/jails/famp/root/media/www/nabla-servers-bower-sample
/mnt/dpool/www/nabla-site-apache
/mnt/dpool/iocage/jails/famp/root/media/www/nabla-site-apache

/mnt/dpool/www/apache24/data
/mnt/dpool/iocage/jails/famp/root/usr/local/www/apache24/data

# backup
cp /usr/local/etc/apache24/extra/*  /media/www/nabla-site-apache/etc/apache24/extra

pkg install php-fpm_exporter redis_exporter node_exporter jail_exporter
sysrc redis_exporter_enable=YES
service redis_exporter start
sysrc jail_exporter=YES
service jail_exporter start
sysrc php-fpm_exporter=YES
service php-fpm_exporter start
sysrc php-node_exporter=YES
service php-node_exporter start

./run-freenas-certificate.sh
# curl https://get.acme.sh | sh -s email=alban.andrieu@albandrieu.com
# NOK chmod +x /root/.acme.sh/acme.sh.csh
chmod 775 /root/.acme.sh/acme.sh.csh

./run-freenas-node.sh

exit 0
