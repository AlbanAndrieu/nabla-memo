#!/bin/bash
set -xv

# https://symfony.com/doc/current/setup/web_server_configuration.html

# https://medium.com/@lubna.altungi/deploying-a-symfony-application-on-apache2-a-step-by-step-guide-to-production-d79223576d52

curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli

symfony check:requirements

php -i
symfony local:php:list

# Run locally
php -S localhost:8000 -t public

exit 0
