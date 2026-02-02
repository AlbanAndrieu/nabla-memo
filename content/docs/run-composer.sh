#!/bin/bash
#set -xv

# PHP Parse error:  syntax error, unexpected ')', expecting '|' or variable (T_VARIABLE) in /usr/share/php/Symfony/Component/Console/Application.php on line 238
# See https://stackoverflow.com/questions/69072898/parse-error-syntax-error-unexpected-expecting-variable-t-variable-symfo
sudo apt remove composer
# sudo apt install composer
# curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install composer using older method given on below link
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

composer -V

rm ~/.config/composer/auth.json
{
    "gitlab-token": {
      "gitlab.com": "glpat-XXX"
    }
}

composer config --global gitlab-oauth.gitlab.com ${GITLAB_WORKFLOW_TOKEN}
composer install

composer config --list

composer require --prefer-dist  -o -vvv --dev phpstan/phpstan

exit 0
