#!/bin/bash
set -xv
sudo launchctl version org.jenkins-ci
sudo launchctl list org.jenkins-ci
sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist
rm -f /var/log/jenkins/jenkins.log
ls /Applications/Jenkins/jenkins.war
cd /Applications/Jenkins/
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
chown jenkins:staff /var/log/jenkins
sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist
sudo su - jenkins
rm -f /var/log/jenkins/jenkins.log
tail -f /var/log/jenkins/jenkins.log
cd /Users/Shared/Jenkins/Home
mkdir init.groovy.d/
cd /Users/Shared/Jenkins/Home/plugins
wget https://updates.jenkins.io/download/plugins/strict-crumb-issuer/2.1.0/strict-crumb-issuer.hpi
sudo launchctl start org.apache.httpd
ls -lrta /private/var/log/apache2/error_log
JENKINS_HOME_/Users/Shared/Jenkins/Home
sudo launchctl list org.jenkins-ci
sudo su - Jenkins
nohup /Library/Application\ Support/Jenkins/jenkins-runner.sh
echo "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java" $javaArgs -jar "$war" $args
exec "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java" $javaArgs -jar "$war" $args
sudo /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/keytool -importcert -alias dev -file UK1VSWCERT01-CA-5.crt -keystore /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/lib/security/cacerts
/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/bin/keytool -importcert -alias dev -file UK1VSWCERT01-CA-5.crt -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/jre/lib/security/cacerts
ls -lrta /Users/Shared/Jenkins/
sudo chown -R jenkins:staff /Users/Shared/Jenkins/
sudo chown -R jenkins:staff /Volumes/DATA/jobs/
ssh -X aandrieu@10.41.40.126
brew install jenkins-lts
cd /usr/local/Cellar/jenkins-lts/2.222.1
nano homebrew.mxcl.jenkins-lts.plist
ln -s /Users/Shared/Jenkins/Home ~/.jenkins
brew services start jenkins-lts
exit 0
