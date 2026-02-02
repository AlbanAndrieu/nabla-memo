#!/bin/bash
set -xv
pkg install security/py-certbot-dns-google
pkg install py311-certbot py311-certbot-apache py311-certbot-dns-cloudflare
pkg install py311-acme
In order to automatically renew the certificates, add this line to
/etc/periodic.conf:
weekly_certbot_enable="YES"
which certbot
certbot --apache -d albandrieu.com -d www.albandrieu.com
/usr/local/www/apache24/data/
/usr/local/www/apache24/data/.well-known/acme-challenge
grep -n 'mod_ssl.so' /usr/local/etc/apache24/httpd.conf
cd /etc
ln -s /usr/local/etc/letsencrypt letsencrypt
less /usr/local/etc/letsencrypt/renewal/albandrieu.com.conf
cert = /usr/local/etc/letsencrypt/live/albandrieu.com/cert.pem
privkey = /usr/local/etc/letsencrypt/live/albandrieu.com/privkey.pem
chain = /usr/local/etc/letsencrypt/live/albandrieu.com/chain.pem
fullchain = /usr/local/etc/letsencrypt/live/albandrieu.com/fullchain.pem
nano /usr/local/etc/apache24/httpd.conf
SSLEngine On
SSLCertificateFile "/usr/local/etc/letsencrypt/live/albandrieu.com/cert.pem"
SSLCertificateKeyFile "/usr/local/etc/letsencrypt/live/albandrieu.com/privkey.pem"
ServerAlias www.albandrieu.com
nano /usr/local/etc/apache24/extra/httpd-vhosts.conf
nano /usr/local/etc/apache24/extra/httpd-ssl.conf
DocumentRoot "/usr/local/www/apache24/data"
ServerName www.albandrieu.com:443
ServerAdmin alban.andrieu@free.fr
ErrorLog "/var/log/httpd-error.log"
TransferLog "/var/log/httpd-access.log"
SSLCertificateFile "/usr/local/etc/letsencrypt/live/albandrieu.com/cert.pem"
SSLCertificateKeyFile "/usr/local/etc/letsencrypt/live/albandrieu.com/privkey.pem"
SSLCertificateChainFile "/usr/local/etc/letsencrypt/live/albandrieu.com/chain.pem"
service apache24 restart
tail -f /var/log/httpd-error.log
http://10.0.0.24/index.pl
http://10.0.0.24/index.cgi
cd /usr/local/www/apache24/data/.well-known/acme-challenge
watch -n 0.1 ls -lRa
/usr/local/bin/certbot certonly --renew-by-default -d albandrieu.com,home.albandrieu.com
service apache24 restart
openssl s_client -connect localhost:443
openssl s_client -connect albandrieu.com:443
exit 0
