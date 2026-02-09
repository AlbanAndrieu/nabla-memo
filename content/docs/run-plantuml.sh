#!/bin/bash
set -xv

# DaC (Diagram as Code)

# See https://docs.gitlab.com/ee/administration/integration/plantuml.html#debianubuntu

# docker run -d --name plantuml -p 8080:8080 plantuml/plantuml-server:tomcat

sudo apt-get install graphviz openjdk-8-jdk git-core maven
git clone https://github.com/plantuml/plantuml-server.git
cd plantuml-server
mvn package
java -jar /home/albandrieu/w/follow/plantuml-server/target/plantuml/WEB-INF/lib/plantuml-1.2022.7.jar -o "docs/" -pdf "src/**.php"

# On Gitlab
# See mermaid https://mermaid-js.github.io/mermaid/#/README

# See Kroki

#sudo apt-get install tomcat9
#sudo cp target/plantuml.war /var/lib/tomcat9/webapps/plantuml.war
#sudo chown tomcat:tomcat /var/lib/tomcat9/webapps/plantuml.war
#sudo service tomcat9 restart

exit 0
