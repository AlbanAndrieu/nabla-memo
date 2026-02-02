#!/bin/bash
set -xv
sudo freebsd-version
jls
sudo jexec 10 freebsd-version
pkg version -v
pkg update&&  pkg upgrade
pkg update -f
pkg_add -r jenkins
http://192.168.0.23:8380/
http://albandrieu.com:8381/
/usr/local/etc/rc.d/jenkins onestart
edit /usr/local/etc/rc.d/jenkins
/usr/local/etc/rc.d/jenkins stop
: ${jenkins_java_opts="-Xmx2048m -XX:MaxPermSize=512m -Djava.awt.headless=true"}
: ${jenkins_args="--webroot=$jenkins_home/war --httpListenAddress=0.0.0.0 --httpPort=8380 --prefix=/"}
echo 'jenkins_enable="YES"' >> /etc/rc.conf
tail -f /var/log/jenkins.log
tail -f /mnt/dpool/jail/software/var/log/httpd-access.log
cd /usr/local/etc/rc.d/
edit jenkins
service jenkins restart
http://albandrieu.com:8380/
192.168.0.23
tail -f /var/log/jenkins.log
user : admin
pass :
id jenkins
edit /etc/group
pw groupadd -n jenkins -g 131
pw useradd -n jenkins -u 117 -d /usr/local/jenkins -s /usr/local/bin/bash
pw groupmod jenkins -m jenkins
pw usermod jenkins -G wheel
chown -R jenkins:jenkins /var/run/jenkins
pw useradd -n albandri -u 1000 -d /usr/local/albandri -s /usr/local/bin/bash
echo 'sshd_enable="YES"' >> /etc/rc.conf
service sshd start
/usr/sbin/freebsd-update&&  freebsd-update install
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/mnt/dpool/bin:/mnt/dpool/jail/software/usr/local/bin
tail -f /var/log/messages
-----------------------
pkg_add -v -r fontconfig
pkg_add -v -r libXfont
pkg_add -v -r libfontenc
pkg_add -v -r ttmkfdir
pkg_add -v -r dejavu
pkg_add -v -r freetype
pkg_add -v -r freetype-tools
ls -lrta /dev/zvol/dpool/
pw groupadd -n docker -g 1002
pw usermod operator < you > -G
docker -d
less /var/log/docker.log
ssh -i OpenSSH_RSA_4096 albandri@freenas
dbus-uuidgen > /var/lib/dbus/machine-id
