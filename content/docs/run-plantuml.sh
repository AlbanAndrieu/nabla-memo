#!/bin/bash
set -xv
sudo apt-get install graphviz openjdk-8-jdk git-core maven
git clone https://github.com/plantuml/plantuml-server.git
cd plantuml-server
mvn package
java -jar /home/albandrieu/w/follow/plantuml-server/target/plantuml/WEB-INF/lib/plantuml-1.2022.7.jar -o "docs/" -pdf "src/**.php"
exit 0
