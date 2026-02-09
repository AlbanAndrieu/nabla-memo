#!/bin/bash
#set -xv

# https://github.com/renovatebot/renovate

cd /home/albanandrieu/w/nabla
sudo npm install -g renovate

# cd /media/albanandrieu/data/follow/renovate-bot
# git clone https://gitlab.com/dockerfiles6/renovate-bot.git
# cd renovate-bot
# rm -rf .git

LOG_LEVEL=debug npx renovate --platform=local --repository-cache=reset
npx --package renovate renovate-config-validator

LOG_LEVEL=debug GITHUB_COM_TOKEN=${GITHUB_COM_TOKEN} npx renovate --platform="gitlab" --repository-cache=reset --token=${RENOVATE_TOKEN} --schedule="" --dry-run=full --onboarding=true haliance/hal
# --endpoint="https://gitlab.ccsd.cnrs.fr/api/v4"

exit 0
