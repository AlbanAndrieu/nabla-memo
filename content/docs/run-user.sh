#!/bin/bash
CURRENT_UID=$(id -u):$(id -g)
echo "CURRENT_UID: $CURRENT_UID"
JENKINS_USER_HOME=${JENKINS_USER_HOME:-/home/jenkins}
DOCKER_USER_HOME=${DOCKER_USER_HOME:-/home/docker}
DOCKER_USER=${DOCKER_USER:-docker}
DOCKER_GROUP=${DOCKER_GROUP:-docker}
DOCKER_UID=${DOCKER_UID:-2000}
DOCKER_GID=${DOCKER_GID:-2000}
printf "\033[1;32mFROM UID:GID: $DOCKER_UID:$DOCKER_GID- DOCKER_USER_HOME: $DOCKER_USER_HOME \033[0m\n"&&printf "\033[1;32mWITH user: $DOCKER_USER\ngroup: $DOCKER_GROUP \033[0m\n"
printf "\033[1;32msudo groupadd -g $DOCKER_GID $DOCKER_GROUP \033[0m\n"
getent passwd 2000||  true
printf "\033[1;32msudo adduser --uid $DOCKER_UID --gid $DOCKER_GID --home $DOCKER_USER_HOME --shell /bin/bash $DOCKER_USER -c \"$DOCKER_USER nabla\" --disabled-login \033[0m\n"
echo "Set password for the jenkins user (you may want to alter this)"
printf "\033[1;32msudo usermod -a -G $DOCKER_GROUP $DOCKER_USER \033[0m\n"
id $DOCKER_USER
echo "Add current user to docker group"
printf "\033[1;32msudo usermod -a -G $DOCKER_GROUP $USER \033[0m\n"
id $USER
echo "Add ansible user"
echo "sudo groupadd -g 3000 ansible"
echo "sudo useradd -m -g ansible --shell /bin/bash ansible -u 3000 -g 3000 -G ansible,docker"
echo "Add nexus user"
printf "\033[1;32msudo useradd --no-create-home --system -s /sbin/nologin nexus -c \"Nexus nabla\" -u 1001 -G root,docker \033[0m\n"
sudo groupadd -g 33 www-data
sudo useradd --no-create-home --system -s /sbin/nologin transmission -c "Transmission nabla" -u 921 -G media,www-data,docker
echo "Add media group"
echo "sudo groupadd -g 8675309 media"
echo "sudo usermod -a -G media $USER"
echo "sudo groupadd -g 80 www"
echo "sudo groupadd -g 1001 tomcat7"
echo "sudo groupadd -g 666 webdav"
echo "sudo groupadd -g 2000 docker"
echo "sudo usermod -a -G docker albandrieu"
echo "sudo usermod -a -G www-data albandrieu"
echo "sudo usermod -a -G docker nexus3"
cd /home
sudo ln -s $USER albanandrieu
sudo chown -h $USER:docker albanandrieu
sudo ln -s $USER albandrieu
sudo chown -h $USER:docker albandrieu
uuidgen
exit 0
