#!/bin/bash
pkg install sudo wget
pkg install py37-ansible-2.8.7
ls -lrta /usr/local/share/examples/py37-ansible/ansible.cfg
pkg install python
pkg install py27-pip
pip install pygal
pkg install py37-ansible-2.8.7
pkg install maven-3.6.3 maven-wrapper-1_2 maven33-3.3.9_1
mvn --version
cd /var/lib/
ln -s /usr/local/jenkins jenkins
ls -lrta /var/lib/jenkins/.m2/repository
cd /usr/ports/security/openssh-askpass/&&  make install clean
ls /usr/local/bin/ssh-askpass
pkg install xorg-vfbserver
pkg install firefox
pkg install chromium
npm install -g bower
npm install -g nsp
npm search phantomjs
pkg info phantomjs
ls -lrta /usr/local/bin/phantomjs
exit 0
