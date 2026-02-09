#!/bin/bash
set -xv

# https://github.com/docker/compose
sudo apt remove docker-compose
pip uninstall docker-compose

wget https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64
sudo mv ~/Downloads/docker-compose-linux-x86_64 /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# sudo pip install docker-compose
docker-compose --version
#Docker Compose version v2.26.1

docker-compose --verbose -f docker-compose-logstash.yml -p TEST up -d
docker-compose -f docker-compose-logstash.yml -p TEST ps

docker-compose rm --all
docker-compose pull
docker-compose build --no-cache
docker-compose up -d --force-recreate

# AttributeError: cython_sources
# https://github.com/yaml/pyyaml/issues/724
# pip install --upgrade pip
# pip 24.0
pip install "cython<3.0.0" && pip install --no-build-isolation pyyaml==5.4.1
# pipenv install  docker-compose

exit 0
