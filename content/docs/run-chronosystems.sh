#!/bin/bash
set -xv
wget http://chrononsystems.com/downloads/recordingserver-3.20.1.187.zip
mv ~/Downloads/recordingserver-3.20.1.187 /workspace
unzip recordingserver-3.20.1.187.zip recordingserver-3.20.1.187
cd /workspace
ln -s recordingserver-3.20.1.187 chronon
cd /workspace/chronon/controllers/linux/controller/bin
geany config.properties
chmod 744 ./installDaemon.sh
chmod -R 744 /workspace/chronon/controllers/linux/controller/bin
sudo ./installDaemon.sh
sudo ./startDaemon.sh
export CHRONON_ARGS="-javaagent:/workspace/chronon/recorder/recorder-3.20.1.187.jar -agentpath:/workspace/chronon/recorder/librecorderagent64-3.0.7.so -XX:-UseSplitVerifier"
export CHRONON_ARGS="-javaagent:/thomsonreuters/home/kgr/chronon/recorder/recorder-3.20.1.187.jar -agentpath:/thomsonreuters/home/kgr/chronon/recorder/librecorderagent64-3.0.7.so -XX:-UseSplitVerifier"
export JAVA_OPTS="$JAVA_OPTS $CHRONON_ARGS"
