#!/bin/bash
set -xv
mkdir -p clair/docker-compose-data/clair-config
wget https://raw.githubusercontent.com/jgsqware/clairctl/master/docker-compose.yml --directory-prefix=clair/docker-compose-data/
wget https://raw.github.com/jgsqware/clairctl/master/docker-compose-data/clair-config/config.yml --directory-prefix=clair/clair-config/
cd clair/docker-compose-data
docker-compose up
curl http://192.168.1.57:6060
docker pull infoslack/dvwa
docker-compose exec clairctl clairctl analyze -l infoslack/dvwa
docker-compose exec clairctl clairctl report -l infoslack/dvwa
make local-dev-up-with-quay
docker-compose up -d quay
wget https://github.com/arminc/clair-scanner/releases/download/v12/clair-scanner_linux_amd64
mv clair-scanner_linux_amd64 clair-scanner
chmod +x clair-scanner
docker pull debian:9.5
docker tag debian:9.5 localhost:8080/nabla/test:latest
docker login https://localhost:8080 -u $CLAIR_USER   -p $CLAIR_PASSWORD
docker push localhost:8080/nabla/test:latest
docker tag registry.hub.docker.com/nabla/ansible-jenkins-slave-docker:latest localhost:8080/nabla/ansible-jenkins-slave-docker:latest
docker push localhost:8080/nabla/ansible-jenkins-slave-docker:latest
curl -u $CLAIR_USER:$CLAIR_PASSWORD     http://localhost:8080/v2/nabla/ansible-jenkins-slave-docker/manifests/latest
exit 0
