#!/bin/bash
set -xv
cd ~
sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
sudo apt-get install webmin
sudo ufw allow 10000
cd /etc/webmin
cp miniserv.pem miniserv.pem-SAV
ls -lrta /etc/ssl/private/
cat /etc/ssl/private/nabla.freeboxos.fr.key /etc/ssl/private/nabla.freeboxos.fr.pem > new_miniserv.pem
famp.albandrieu.com
nabla.albandrieu.com
/usr/local/www/apache24/data/
service webmin restart
cpan install DBI
cpan install DBD::mysql
cpan install Authen::OATH
echo "https://albandrieu.com:10000/"
./run-letsencrypt.sh
ls -lrta /etc/webmin/miniserv.csr
tail -f /var/webmin/webmin.log
tail -f /var/webmin/miniserv.log
tail -f /var/webmin/miniserv.error
exit 0
