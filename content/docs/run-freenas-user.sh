#!/bin/bash
id jenkins
edit /etc/group
pkg install bash
pw groupadd -n docker -g 2000
pw groupadd -n jenkins -g 131
ln -s /media/jenkins-slave /usr/local/jenkins
pw useradd -n jenkins -u 117 -d /usr/local/jenkins -s /usr/local/bin/bash
pw groupmod jenkins -m jenkins
pw groupmod docker -m jenkins
pw usermod jenkins -G wheel
chown jenkins:jenkins /usr/local/jenkins
chown -R jenkins:jenkins /var/run/jenkins
ssh -v jenkins@192.168.1.61
ssh -X jenkins@192.168.1.61
ssh -v jenkins@192.168.0.29
[jenkins@freenas ~/.ssh]$ ssh-keygen -t rsa
The key fingerprint is:
SHA256:l7g/OFaD0EKFNmHhTvmEVlsF+oQA3fI6YPtuTvIoWNQ jenkins@apache
less ~/.ssh/id_rsa.pub
ssh-rsa KEY jenkins@freenas.local
ssh-rsa KEY jenkins@albandri
ssh -X jenkins@192.168.1.62
ssh-keyscan -t rsa 192.168.1.61 >> /mnt/dpool/jenkins/.ssh/known_hosts
ssh-keyscan -t rsa 192.168.1.61 >> ~/.ssh/known_hosts
cat .ssh/id_rsa.pub|  ssh jenkins@192.168.1.61 'cat >> .ssh/authorized_keys'
pw useradd -n albandri -u 1000 -d /usr/local/albandri -s /usr/local/bin/bash
ssh jenkins@192.168.1.62
ssh-keyscan -t rsa 192.168.0.29 >> /mnt/dpool/jenkins/.ssh/known_hosts
pw groupadd -n bower -g 34
pw useradd -n bower -u 34 -d /nonexistent -s /usr/sbin/nologin
exit 0
