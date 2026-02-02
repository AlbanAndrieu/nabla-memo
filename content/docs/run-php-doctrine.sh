#!/bin/bash
set -xv
php bin/console --env=dev doctrine:fixtures:load
php bin/console doctrine:migrations:execute --up 20250806xxxxxx
exit 0
