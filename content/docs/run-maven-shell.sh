#!/bin/bash
set -xv

#http://stackoverflow.com/questions/10254968/maven-how-do-i-install-mvnsh
wget http://repo1.maven.org/maven2/org/sonatype/maven/shell/dist/mvnsh-assembly/1.1.0/mvnsh-assembly-1.1.0-bin.tar.gz
tar -xvf mvnsh-assembly-1.1.0-bin.tar.gz

cd ~/bin/
ln -s /workspace/mvnsh-1.1.0/bin/mvnsh mvnsh

sudo apt-get install --no-install-recommends gnome-panel
gnome-desktop-item-edit --create-new ~/Desktop

ll /usr/share/maven/bin
ll /opt/maven/apache-maven-3.5.0/
ll /usr/local/bin//mvn

sudo update-alternatives --config mvn

exit 0
