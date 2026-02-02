#!/bin/bash
set -xv
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh'|  sudo -E bash
sudo apt install symfony-cli
symfony check:requirements
php -i
symfony local:php:list
php -S localhost:8000 -t public
exit 0
