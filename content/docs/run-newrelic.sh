#!/bin/bash
set -xv
sudo service newrelic-sysmond status
sudo cp ~/newrelic-java-3.12.1.zip /usr/share/tomcat7
cd /usr/share/tomcat7
sudo chown -R tomcat7:tomcat7 newrelic-java-3.12.1.zip
sudo unzip newrelic-java-3.12.1.zip
cd newrelic
java -jar newrelic.jar install
export JAVA_OPTIONS="$JAVA_OPTIONS -javaagent:/full/path/to/newrelic.jar"
cd /usr/share/tomcat7
sudo wget http://dripstat.com/dl/dripstat_agent-5.1.2.zip
sudo chown -R tomcat7:tomcat7 dripstat_agent-5.1.2.zip
sudo unzip dripstat_agent-5.1.2.zip
cd dripstat
sudo java -jar dripstat.jar install -n "nabla" -l b2fj9n8kTx25Ek8aG4HLRQ
sudo service tomcat7 restart
docker run \
  --detach \
  --name newrelic-infra \
  --network=host \
  --cap-add=SYS_PTRACE \
  --privileged \
  --pid=host \
  --volume "/:/host:ro" \
  --volume "/var/run/docker.sock:/var/run/docker.sock" \
  --volume "newrelic-infra:/etc/newrelic-infra" \
  --env NRIA_LICENSE_KEY=$NRIA_LICENSE_KEY \
  newrelic/infrastructure:latest
exit 0
