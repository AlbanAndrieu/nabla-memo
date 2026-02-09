#!/bin/bash
#set -xv

#install port
#portsnap fetch && portsnap extract
#cd /usr/ports/java/openjdk7
#make clean install

pkg update -f
pkg install openjdk20

#jdk8
#cd /usr/ports/java/openjdk8 && make clean install
#pkg install openjdk8

# ls -lrta /usr/local/openjdk8

java -version

exit 0
