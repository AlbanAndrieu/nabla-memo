#!/bin/bash
set -xv
sudo apt remove jmeter
sudo apt install openjdk-11-jdk
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.tgz
tar xf apache-jmeter-5.6.tgz
http://jmeter-plugins.org/wiki/PerfMonAgent/
cd /workspace/users/albandri30/nabla-project-interview-visma/gui
pushd apache-jmeter-5.6/bin/&&  ./jmeter.sh -n -t src/test/front.jmx -l outputFile.jtl
exit 0
