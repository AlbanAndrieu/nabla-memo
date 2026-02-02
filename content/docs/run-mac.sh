#!/bin/bash
set -xv
pkgutil --pkg-info=com.apple.pkg.CLTools_Executables
sudo xcodebuild -license
sudo xcode-select --install
sudo xcode-select -p
sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments pip install ansible
launchctl limit maxfiles
sudo launchctl limit maxfiles 1024 unlimited
launchctl limit maxfiles
ulimit -n
git clone https://github.com/geerlingguy/mac-dev-playbook
cd mac-dev-playbook
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml -i inventory -K
sw_vers -productVersion
wget https://distfiles.macports.org/MacPorts/MacPorts-2.4.3-10.13-HighSierra.pkg
sudo installer -pkg MacPorts-2.4.3-10.13-HighSierra.pkg -target /
sudo /opt/local/bin/port version
sudo nano /opt/local/etc/macports/sources.conf
sudo /opt/local/bin/port -v selfupdate
sudo /opt/local/bin/port list|  grep wget
sudo /opt/local/bin/port -t install wget
sudo /opt/local/bin/port install openssl
sudo /opt/local/bin/port install py-ansible
/opt/local/bin/port -qv installed > myports.txt
/opt/local/bin/port echo requested|  cut -d ' ' -f 1 > requested.txt
git clone https://github.com/geerlingguy/mac-dev-playbook
cd mac-dev-playbook
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml -i inventory -K
sudo defaults read /Library/LaunchDaemons/org.jenkins-ci
sudo defaults write /Library/LaunchDaemons/org.jenkins-ci httpPort 8380
sudo defaults write /Library/LaunchDaemons/org.jenkins-ci prefix /jenkins
sudo chown jenkins /var/log/jenkins
sudo chown jenkins:jenkins /Users/Shared/Jenkins
sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist
sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist
/Library/Application Support/Jenkins/jenkins-runner.sh
/usr/libexec/java_home
/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
sudo keytool -importcert -alias dev -file UK1VSWCERT01-CA-5.crt -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/jre/lib/security/cacerts
sudo systemsetup -getcomputersleep
sudo systemsetup -setcomputersleep Never
exit 0
