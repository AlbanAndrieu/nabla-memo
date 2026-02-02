#!/bin/bash
set -xv
cd /workspace
sudo mkdir fitnesse
cd fitnesse/
sudo wget https://cleancoder.ci.cloudbees.com/job/fitnesse/lastStableBuild/artifact/dist/fitnesse-standalone.jar
cd /workspace
sudo git clone git://github.com/xebia/Xebium
cd /workspace/Xebium
mvn -Pfitnesse test
