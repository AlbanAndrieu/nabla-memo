#!/bin/bash
set -xv

#On freenas apache jail

pkg install security/py-certbot-dns-google
# pkg install py39-certbot py39-certbot-apache
pkg install py311-certbot py311-certbot-apache py311-certbot-dns-cloudflare # py311-certbot-dns-ovh
pkg install py311-acme
# pkg install security/py-certbot-apache

# See https://forums.freebsd.org/threads/certbot.84581/

In order to automatically renew the certificates, add this line to
/etc/periodic.conf:

weekly_certbot_enable="YES"
#echo "weekly_certbot_enable="YES"" >>/etc/periodic.conf

which certbot

#sudo certbot certonly --standalone -d albandrieu.com -d www.albandrieu.com -d famp.albandrieu.com -d nabla.albandrieu.com -d freenas.albandrieu.com
certbot --apache -d albandrieu.com -d www.albandrieu.com

# Should give

#Unable to read ssl_module file; not disabling session tickets.
#Requesting a certificate for albandrieu.com and www.albandrieu.com
#
#Successfully received certificate.
#Certificate is saved at: /usr/local/etc/letsencrypt/live/albandrieu.com/fullchain.pem
#Key is saved at:         /usr/local/etc/letsencrypt/live/albandrieu.com/privkey.pem
#This certificate expires on 2023-01-05.
#These files will be updated when the certificate renews.
#
#Deploying certificate
#Successfully deployed certificate for albandrieu.com to /usr/local/etc/apache24/extra/httpd-vhosts-le-ssl.conf
#Successfully deployed certificate for www.albandrieu.com to /usr/local/etc/apache24/extra/httpd-vhosts-le-ssl.conf
#Congratulations! You have successfully enabled HTTPS on https://albandrieu.com and https://www.albandrieu.com
#
#NEXT STEPS:
#- The certificate will need to be renewed before it expires. Certbot can automatically renew the certificate in the background, but you may need to take steps to enable that functionality. See https://certbot.org/renewal-setup for instructions.
#
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#If you like Certbot, please consider supporting our work by:
# * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
# * Donating to EFF:                    https://eff.org/donate-le
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Use options 4 webroot
/usr/local/www/apache24/data/

/usr/local/www/apache24/data/.well-known/acme-challenge

#echo "" > /var/www/nabla-site-apache/.well-known/acme-challenge/.htaccess

# Add https
# https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-freebsd-12-0
grep -n 'mod_ssl.so' /usr/local/etc/apache24/httpd.conf

cd /etc
ln -s /usr/local/etc/letsencrypt letsencrypt

# On freenas webmin

#[root@apache /usr/ports/security/py-certbot]# tail -f /var/log/letsencrypt/letsencrypt.log
#2020-03-29 00:56:22,086:DEBUG:certbot._internal.cli:Var manual_public_ip_logging_ok=True (set by user).
#2020-03-29 00:56:22,086:DEBUG:certbot._internal.cli:Var webroot_path=/usr/local/www/apache24/data/ (set by user).
#2020-03-29 00:56:22,086:DEBUG:certbot._internal.cli:Var webroot_path=/usr/local/www/apache24/data/ (set by user).
#2020-03-29 00:56:22,086:DEBUG:certbot._internal.cli:Var webroot_map={'webroot_path'} (set by user).
#2020-03-29 00:56:22,087:DEBUG:certbot._internal.storage:Writing new config /usr/local/etc/letsencrypt/renewal/albandrieu.com.conf.
#2020-03-29 00:56:22,090:DEBUG:certbot._internal.reporter:Reporting to user: Congratulations! Your certificate and chain have been saved at:
#/usr/local/etc/letsencrypt/live/albandrieu.com/fullchain.pem
#Your key file has been saved at:
#/usr/local/etc/letsencrypt/live/albandrieu.com/privkey.pem
#Your cert will expire on 2020-06-26. To obtain a new or tweaked version of this certificate in the future, simply run certbot again. To non-interactively renew *all* of your certificates, run "certbot renew"

less /usr/local/etc/letsencrypt/renewal/albandrieu.com.conf

cert = /usr/local/etc/letsencrypt/live/albandrieu.com/cert.pem
privkey = /usr/local/etc/letsencrypt/live/albandrieu.com/privkey.pem
chain = /usr/local/etc/letsencrypt/live/albandrieu.com/chain.pem
fullchain = /usr/local/etc/letsencrypt/live/albandrieu.com/fullchain.pem

nano /usr/local/etc/apache24/httpd.conf

SSLEngine On
SSLCertificateFile "/usr/local/etc/letsencrypt/live/albandrieu.com/cert.pem"
SSLCertificateKeyFile "/usr/local/etc/letsencrypt/live/albandrieu.com/privkey.pem"

#certbot certonly --standalone -d albandrieu.com

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

# below is working as well

/usr/local/bin/certbot certonly --renew-by-default -d albandrieu.com,home.albandrieu.com

service apache24 restart

#See https://albandrieu.com/nabla/index/index.html

openssl s_client -connect localhost:443
openssl s_client -connect albandrieu.com:443

exit 0
