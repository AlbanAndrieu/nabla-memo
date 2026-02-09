#!/bin/bash
set -xv

# Issue Error in NonGUIDriver com.thoughtworks.xstream.security.ForbiddenClassException: org.apache.jmeter.save.ScriptWrapper
sudo apt remove jmeter

#sudo apt install openjdk-8-jdk
#sudo apt install openjdk-8-jdk
#sudo apt install openjdk-11-dbg
sudo apt install openjdk-11-jdk
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.tgz
tar xf apache-jmeter-5.6.tgz
# pushd apache-jmeter-5.6/bin/ && ./jmeter.sh

#http://arodrigues.developpez.com/tutoriels/java/performance/developper-plan-test-avec-jmeter/

#http://jmeter-plugins.org/wiki/WebDriverTutorial/

#Install perfMon
http://jmeter-plugins.org/wiki/PerfMonAgent/

# On the target host
#/usr/local/jmeter-agent/startAgent.sh --udp-port 0 --tcp-port 3450

# Run jmeter
cd /workspace/users/albandri30/nabla-project-interview-visma/gui
# NOK /usr/local/jmeter/apache-jmeter-5.6/bin/jmeter -n -t src/test/front.jmx -l outputFile.jtl
pushd apache-jmeter-5.6/bin/ && ./jmeter.sh -n -t src/test/front.jmx -l outputFile.jtl

exit 0
