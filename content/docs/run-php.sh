#!/bin/bash
set -xv

php -v

sudo apt install ca-certificates apt-transport-https lsb-release

# BELOW is NOK
# apt-key add /etc/apt/trusted.gpg.d/php.gpg
#wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
#echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
# deb https://packages.sury.org/php/ stretch main

# https://www.linuxcapable.com/how-to-install-php-8-1-on-ubuntu-20-04/
sudo apt install software-properties-common && sudo add-apt-repository ppa:ondrej/php -y

#CAVEATS:
#1. If you are using php-gearman, you need to add ppa:ondrej/pkg-gearman
#2. If you are using apache2, you are advised to add ppa:ondrej/apache2
#3. If you are using nginx, you are advised to add ppa:ondrej/nginx-mainline
#   or ppa:ondrej/nginx

sudo apt install php libapache2-mod-php8.1

# See https://www.debian-fr.org/t/apt-update-ko-avec-packages-sury-org-php-7-2/78272
# sudo apt install php7.2-cli php7.2-common php7.2-curl php7.2-mbstring php7.2-mysql php7.2-xml
# sudo apt-get install libpq-dev
sudo apt install php8.4-cli php8.4-common php8.4-curl php8.4-imap php8.4-mbstring php8.4-xml php8.4-xdebug php8.4-zip

sudo systemctl status php8.4-fpm

# sudo apt-get install php php-fpm php-cli php-curl php-pgsql php-pear
sudo apt-get install php-doctrine-orm php-doctrine-dbal

apt-get install -y acl vim iputils-ping net-tools tar postgresql-client

#docker-php-ext-configure imap --with-kerberos --with-imap-ssl
#docker-php-ext-install dom mbstring zip pdo pdo_pgsql intl tidy imap sockets
#pecl install ssh2-1.1.2 redis
#docker-php-ext-enable ssh2 redis

# Install xdebug
sudo apt-get install php-pear
pecl install xdebug
#docker-php-ext-enable xdebug

#Reset the default PHP back to PHP5 (optional)
#update-alternatives --set php /usr/bin/php5

# sudo apt install composer
./run-composer.sh

composer require orm
composer require doctrine/orm
composer require doctrine/dbal

rm -rf vendor/ app/cache/ app/logs/ composer.lock
composer clearcache
composer config --global --auth gitlab-token.gitlab.com ${GITLAB_FULL_PRIVATE_TOKEN}
composer install --prefer-dist --optimize-autoloader
#composer update --no-progress --prefer-dist --optimize-autoloader --no-interaction

# /home/albandrieu/.config/composer/auth.json

# php bin/console cache:clear
# php bin/console cache:warmup

sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
# sudo add-apt-repository ppa:ondrej/apache2

sudo apt-get update
sudo apt-get install php7.4 php7.4-tidy php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath php7.4-dev php7.4-imap php7.4-pgsql php7.4-redis php7.4-dom php7.4-xdebug

export PHP_VERSION=8.4
sudo apt-get install php${PHP_VERSION}-tidy
    php${PHP_VERSION}-tidy \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-pgsql \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-common
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-sockets

# sudo apt-get install -y php7.4-{bcmath,bz2,intl,gd,mbstring,mysql,zip,sqlite,soap,imagick,curl,json,xml}
composer update

sudo update-alternatives --config php

---------

ServiceController.php

    /**
     * @Route("/test", name="test", options={"expose"=true}, methods={"GET"})
     */
    /*
    public function test(): Response
    {
        return new Response('<html><body>'.phpinfo().'</body></html>');
    }
    */

-----------


# Issue Untrusted Host "127.0.0.1"
TRUSTED_HOSTS='^(localhost|jusmundi\.local|jusconnect\.local|haproxy|172\.26\.43\.152|82\.66\.4\.247)$'

./run-php-fpm.sh

exit 0
