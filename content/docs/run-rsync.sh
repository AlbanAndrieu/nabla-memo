#!/bin/bash
set -xv
showmount -e nabla
chmod -R o+r /mnt/dpool/jenkins
chmod -R o+r /mnt/dpool/backup
chmod -R o+r /mnt/dpool/media/music
chmod -R a+rX  /mnt/dpool/nexus
sudo mkdir /data/ftp
sudo rsync -rltgoDv --ignore-errors --stats /media/ftp /data/
sudo mkdir /data/photo
sudo rsync -rltgoDv --ignore-errors --stats /media/photo /data/
sudo mkdir /data/backup
sudo rsync -rltgoDv --ignore-errors --stats /media/backup /data/
sudo mkdir /data/archive
sudo rsync -rltgoDv --ignore-errors --stats /media/archive /data/
sudo mkdir /data/jenkins
sudo rsync -rltgoDv --ignore-errors --stats /media/jenkins /data/
sudo mkdir /data/music
sudo rsync -rltgoDv --ignore-errors --stats /media/music /data/
sudo mkdir /data/bitcoin
sudo rsync -rltgoDv --ignore-errors --stats /media/bower /data/
sudo rsync -rltgoDv --ignore-errors --stats /media/nexus /data/
sudo rsync -rltgoDv --ignore-errors --stats /media/home/albandri /data/home
sudo rsync -rltgoDv --ignore-errors --stats /media/home/albandrieu /data/home
sudo rsync -rltgoDv --ignore-errors --stats /media/www /data/
echo "Synchronization from freenas NABLA done"
rsync -avh --no-perms --no-group --no-owner --ignore-errors --stats /data/ftp /media/
rsync -rltgoDv --ignore-errors --stats /data/backup/* /media/backup/lab
rsync -rltgoDv --ignore-errors --stats /data/photo/* /media/photo
rsync -rltgoDv --ignore-errors --stats /data/music/* /media/music
sudo chmod -R g+r /data/archive/
rsync -rltgoDv --ignore-errors --stats /data/archive/* /media/archive
rsync -rltgoDv --ignore-errors --stats /data/bower/* /media/bower
sudo chmod -R g+r /data/jenkins/
sudo chmod -R g+r /data/jenkins/.*
sudo chmod -R o+r /data/jenkins/secrets
rsync -rltgoDv --ignore-errors --stats /data/jenkins/* /media/jenkins
rsync -rltgoDv --ignore-errors --stats  ~/.config/anythingllm-desktop/storage/models/ /media/model
echo "Synchronization to freenas NABLA done"
