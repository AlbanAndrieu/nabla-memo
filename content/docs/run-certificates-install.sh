#!/bin/bash
set -xv
sudo apt-get install openssl ssl-cert
sudo apt-get install certbot
mkdir --parent '/etc/ssl/private'
sudo addgroup --system 'ssl-cert'
sudo chown -R root:ssl-cert '/etc/ssl/private'
sudo chmod 710 '/etc/ssl/private'
sudo chmod 440 '/etc/ssl/private/'
export SSL_KEY_NAME="albandrieu.com"
if [ -e '/etc/ssl/csr-informations' ];then
  source '/etc/ssl/csr-informations'
  cat '/etc/ssl/csr-informations'
else
  echo -e "

#####################
Error: No SSL information available."
fi
SSL_COUNTRY="fr"
SSL_PROVINCE="IleDeFrance"
SSL_CITY="Paris"
SSL_EMAIL="alban.andrieu@free.fr"
echo -e "# SSL CSR information.
SSL_COUNTRY=\"$SSL_COUNTRY\"
SSL_PROVINCE=\"$SSL_PROVINCE\"
SSL_CITY=\"$SSL_CITY\"
SSL_EMAIL=\"$SSL_EMAIL\"" > \
'/etc/ssl/csr-informations'
openssl genrsa -out "/etc/ssl/private/$SSL_KEY_NAME.key"   2048
chown root:ssl-cert "/etc/ssl/private/$SSL_KEY_NAME.key"
chmod 440 "/etc/ssl/private/$SSL_KEY_NAME.key"
cd /etc/ssl/private/
openssl rsa -in /etc/ssl/private/$SSL_KEY_NAME.key   -text -noout
openssl rsa -in /etc/ssl/private/$SSL_KEY_NAME.key   -pubout -out $SSL_KEY_NAME.pem
ls -lrt /etc/ssl/private/
exit 0
