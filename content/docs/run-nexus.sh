#!/bin/bash
set -xv
cd /etc/init.d
sudo ln -s /workspace/nexus/bin/nexus nexus
sudo update-rc.d nexus defaults 06 94
ls -l /etc/rc?.d/*nexus
sudo useradd -M -s /sbin/nologin nexus -c "Nexus nabla" -u 1001 -g 1001 -G jenkins,docker
sudo addgroup data
sudo adduser nexus data
cd /workspace
sudo chown -R nexus.data sonatype-work
sudo chown -R nexus.data nexus
sudo chown -R nexus.data nexus-2.3.0-04
cd /workspace/nexus
./bin/nexus console
default login/password is admin/admin123/microsoft
cat /usr/local/nexus/sonatype-work/nexus3/admin.password
sudo update-rc.d -f nexus remove
sudo update-rc.d nexus defaults 10 90
sudo service nexus start
java -jar /workspace/users/albandri10/Downloads/application-check-1.21.3.jar
sudo nano ./bin/jsw/conf/wrapper.conf
sudo nano /workspace/nexus/bin/nexus
sudo chown -R nexus:nexus /workspace/sonatype-work
sudo cp /workspace/divers/nexus-npm-repository-plugin-master/target/nexus-npm-repository-plugin-0.0.2-SNAPSHOT-bundle.zip /workspace/sonatype-work/nexus/plugin-repository
cd /workspace/sonatype-work/nexus/plugin-repository
sudo chown nexus:nexus nexus-npm-repository-plugin-0.0.2-SNAPSHOT-bundle.zip
sudo jar xf nexus-npm-repository-plugin-0.0.2-SNAPSHOT-bundle.zip
sudo chown -R nexus:nexus /workspace/sonatype-work/nexus/plugin-repository/nexus-npm-repository-plugin-0.0.2-SNAPSHOT
npm config set registry http://albandrieu.com:8081/nexus/content/npm/registry.npmjs.org/
tail -f /usr/local/nexus/sonatype-work/nexus3/log/nexus.log
sudo systemctl disable nexus.service
sudo systemctl enable nexus.service
sudo geany /var/lib/dpkg/info/nexus-repository-manager.prerm
cd /etc/apt/sources.list.d/
sudo wget -P /etc/apt/sources.list.d/ https://repo.sonatype.com/repository/community-hosted/deb/sonatype-community.list
wget -q -O - https://repo.sonatype.com/repository/community-hosted/pki/deb-gpg/DEB-GPG-KEY-Sonatype.asc|  sudo apt-key add -
sudo apt-get update&&  sudo apt-get install nexus-repository-manager
ls -lrta /opt/sonatype/nexus3/bin/nexus
cd /opt/sonatype/sonatype-work/nexus3
sudo apt-get remove nexus-repository-manager
user nexus3
sudo journalctl -xeu nexus.service
cd /opt/sonatype/sonatype-work
mkdir nexus3-docker
chmod 777 nexus3-docker
docker run -d -p 8081:8081 -u 998:996 --userns=host -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v /opt/sonatype/sonatype-work/nexus3-docker:/nexus-data --name albandrieu-nexus sonatype/nexus3:3.0.0
docker run -d -p 8081:8081 -v /opt/sonatype/sonatype-work/nexus3-docker:/nexus-data --name albandrieu-nexus sonatype/nexus3:3.0.0
sudo apt install openjdk-21-jdk -y
cd /opt
sudo curl -L -O https://download.sonatype.com/nexus/3/nexus-3.87.1-01-linux-x86_64.tar.gz
sudo tar -xvzf nexus-3.87.1-01-linux-x86_64.tar.gz
sudo ln -s nexus-3.87.1-01 nexus
sudo rm nexus-3.87.1-01-linux-x86_64.tar.gz
sudo adduser nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo geany /etc/systemd/system/nexus.service
sudo systemctl start nexus
tail -f /opt/sonatype-work/nexus3/log/nexus.log
echo "http://localhost:8081/#login"
sudo cat /opt/sonatype-work/nexus3/admin.password
export SMTP_HOST="smtp.gmail.com"
export SMTP_PORT="587"
export SMTP_SECURITY="starttls"
export SMTP_FROM="alban.andrieu@nabla.mobi"
export SMTP_USERNAME="alban.andrieu@nabla.mobi"
ls -lrta /data/sonatype/sonatype-work/nexus3
ls -lrta /data/nexus/storage/
ll /home/albandrieu/w/ansible-nabla/playbooks/nexus.yml
exit
