#!/bin/bash
cd /home/albanandrieu/w/nabla
sudo npm install -g renovate
LOG_LEVEL=debug npx renovate --platform=local --repository-cache=reset
npx --package renovate renovate-config-validator
LOG_LEVEL=debug GITHUB_COM_TOKEN=$GITHUB_COM_TOKEN   npx renovate --platform="gitlab" --repository-cache=reset --token=$RENOVATE_TOKEN   --schedule="" --dry-run=full --onboarding=true haliance/hal
exit 0
