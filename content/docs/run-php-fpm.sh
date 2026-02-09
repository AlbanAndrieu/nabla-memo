#!/bin/bash
set -xv

export PHP_VERSION=8.4

sudo apt-get -y install curl zip unzip

echo -e "\e[96m Adding PPA  \e[39m"
# sudo add-apt-repository -y ppa:ondrej/apache2
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

echo -e "\e[96m Installing apache  \e[39m"
sudo apt-get -y install apache2

export INSTALL_PHP_VER=${1:-8.4}

echo -e "\e[96m Installing php - ${INSTALL_PHP_VER} \e[39m"
sudo apt-get -y install "php${INSTALL_PHP_VER}-cli" "libapache2-mod-php${INSTALL_PHP_VER}"
sudo a2enmod "php${INSTALL_PHP_VER}"

# php7.4-sqlite3

# PHP Startup: Unable to load dynamic library 'gd.so' (tried: /usr/lib/php/20230831/gd.so
php -i | grep -i gd
sudo apt install --reinstall libgd3
sudo apt install --reinstall php-gd
sudo apt purge php-gd
mv /etc/php/8.3/cli/conf.d/20-gd.ini /etc/php/8.3/cli/conf.d/20-gd.ini-TODELET

echo -e "\e[96m Installing php extensions \e[39m"
if [ "$INSTALL_PHP_VER" = "7.4" ]; then
  sudo apt-get -y install php7.4-json php7.4-mysql php7.4-curl php7.4-ctype php7.4-uuid \
    php7.4-iconv php7.4-mbstring php7.4-gd php7.4-intl php7.4-xml \
    php7.4-zip php7.4-gettext php7.4-pgsql php7.4-bcmath php7.4-redis \
    php7.4-readline php7.4-soap php7.4-igbinary php7.4-msgpack \
else
  sudo apt-get -y install php${PHP_VERSION}-cli php${PHP_VERSION}-curl php${PHP_VERSION}-ctype php${PHP_VERSION}-uuid \
    php${PHP_VERSION}-pgsql php${PHP_VERSION}-sqlite3 php${PHP_VERSION}-gd \
    php${PHP_VERSION}-imap php${PHP_VERSION}-mysql php${PHP_VERSION}-mbstring php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-xml php${PHP_VERSION}-zip php${PHP_VERSION}-bcmath php${PHP_VERSION}-soap php${PHP_VERSION}-gettext \
    php${PHP_VERSION}-intl php${PHP_VERSION}-readline \
    php${PHP_VERSION}-msgpack php${PHP_VERSION}-igbinary php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-redis php${PHP_VERSION}-grpc php${PHP_VERSION}-opcache
fi

####### DOING ########

sudo apt-get install php${PHP_VERSION}-fpm

a2enmod proxy_fcgi setenvif
a2enconf php${PHP_VERSION}-fpm

# Issue https://askubuntu.com/questions/1529224/php8-3-fpm-installation-fails-with-post-installation-script-error
sudo systemctl edit php${PHP_VERSION}-fpm
[Service]
Type=exec

sudo apt install -f
sudo systemctl restart php8.4-fpm

service php8.4-fpm status
sudo systemctl enable php8.4-fpm

# a2enmod proxy_fcgi setenvif
# sudo a2enconf php8.4-fpm

#sudo apt-get -y install php-xdebug
sudo phpenmod curl

# Enable some apache modules
sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod headers

update-alternatives --config php
# choose 7.4
cd /run/php
sudo ln -s /etc/alternatives/php-fpm.sock php-fpm.sock
cd /etc/alternatives
rm php-fpm.sock
sudo ln -s /run/php/php7.4-fpm.sock php-fpm.sock

sudo apt-get install php${PHP_VERSION}-fpm

sudo apt install composer
composer create-project "symfony/skeleton ${SYMFONY_VERSION}" . --stability=stable --prefer-dist --no-dev --no-progress --no-interaction
# ERROR
# PHP Warning:  PHP Startup: Unable to load dynamic library 'pdo_sqlite.so' (tried: /usr/lib/php/20190902/pdo_sqlite.so (/usr/lib/php/20190902/pdo_sqlite.so: undefined symbol: php_pdo_unregister_driver)
ll /usr/lib/php/20190902/pdo_sqlite.so
sudo apt remove php-sqlite3 sqlite3
ll /etc/php/7.4/cli/conf.d/20-pdo_sqlite.ini
ll /etc/php/7.4/cli/conf.d/20-sqlite3.ini

# sudo dpkg --configure -a
sudo apt-get install libapache2-mod-php7.4 --reinstall
#  PHP message: PHP Warning:  PHP Startup: Unable to load dynamic library 'pdo_sqlite.so'
php -i | grep sqlite

sudo apt install php7.4-sqlite3
# sudo apt install php8.3-sqlite3
# cd /usr/local/lib
# sudo mv libsqlite3.so.0 ./libsqlite3.so.0.back
# PHP Startup: Unable to load dynamic library 'pdo_sqlite.so
sudo apt install php-sqlite3
sudo service apache2 restart
ls -l /usr/lib/php/20230831/pdo_sqlite.so

php -i | grep sqlite
dpkg -l php7.4-sqlite3
sudo apt install --reinstall php7.4-sqlite3 libsqlite3-0
sudo apt install -f
# info: Executing deferred 'a2enconf gitweb' for package gitweb
# ERROR: Conf gitweb does not exist!
sudo apt purge gitweb

sudo apt-get install php-pear
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv

sudo apt-get install php-xml php7.4-xml

sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php7.4-fpm

# update both php.ini file
nano /etc/php/7.x/apache2/php.ini
nano /etc/php/7.x/cli/php.ini

sudo apt install --reinstall php7.4-cli
cd /etc/php/7.4/cli/conf.d/
geany 20-pdo_sqlite.ini 20-sqlite3.ini

# ubuntu
sudo geany /etc/php/7.4/fpm/php.ini
date.timezone = Europe/Paris

sudo systemctl disable php7.3-fpm.service
sudo systemctl disable php8.3-fpm.service
sudo systemctl restart php7.4-fpm.service
sudo systemctl status php7.4-fpm.service
sudo journalctl -xeu php7.4-fpm.service
/usr/sbin/php-fpm7.4 --nodaemonize --fpm-config /etc/php/7.4/fpm/php-fpm.conf
# ERROR: failed to open error_log (/var/log/php7.4-fpm.log): Permission denied (13)
# sudo chown www-data:www-data /var/log/php7.4-fpm.log
sudo rm -Rf /var/log/php*
sudo chmod 777 /var/log/php7.4-fpm.log

# https://docs.vultr.com/how-to-install-php-and-php-fpm-on-ubuntu-24-04
sudo apt-cache policy php7.4-fpm

echo -e "\e[96m Installing composer \e[39m"
# Notice: Still using the good old way
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --force --filename=composer

# Check php version
php -v

# Check apache version
apachectl -v

# Check if php is working or not
php -r 'echo "\nYour PHP installation is working fine.\n";'

# Fix composer folder permissions
mkdir -p ~/.composer
sudo chown -R "$USER" "$HOME/.composer"

# Check composer version
composer --version

echo -e "\e[92m Open http://localhost/ to check if apache is working or not. \e[39m"

# Clean up cache

# Fix issue
# Got error 'PHP message: PHP Warning: PHP Request Startup: Failed to open stream: Permission denied in Unknown on line 0; Unable to open primary script: /var/www/nabla-site-apache/api/index.php (Permission denied)
aa-teardown

exit 0
