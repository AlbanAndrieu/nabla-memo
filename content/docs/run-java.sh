#!/bin/bash
set -xv
sudo update-alternatives --config java
sudo update-alternatives --config javac
sudo apt install openjdk-17-dbg
sudo add-apt-repository ppa:linuxuprising/java
sudo apt-get update
sudo update-java-alternatives --list
sudo update-java-alternatives -s java-14-oracle
sudo update-java-alternatives -s java-1.8.0-openjdk-amd64
sudo update-java-alternatives -s java-1.11.0-openjdk-amd64
sudo update-java-alternatives -s java-1.21.0-openjdk-amd64
sudo update-java-alternatives -s jdk-21-oracle-x64
ls -lrta /usr/lib/jvm/jdk-21-oracle-x64/bin/jwebserver
export JAVA_HOME="$(update-alternatives --query java|  grep 'Value: '|  sed -e 's/Value: //;s?/jre/bin/java??;')"
sudo rm /etc/profile.d/jdk.sh /etc/profile.d/jdk.csh
sudo apt install openjdk-21-jdk
exit 0
