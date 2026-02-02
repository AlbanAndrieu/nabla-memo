#!/bin/bash
set -xv
sudo apt-get install -y samba samba-common python-glade2 system-config-samba
lsof|  grep '/srv'
less /etc/mtab
sudo mkdir -p /srv/samba/share
sudo chown nobody:nogroup /srv/samba/share/
sudo nano /etc/samba/smb.conf
[global]
workgroup = WORKGROUP
server string = Samba Server %v
netbios name = ubuntu
security = user
map to guest = bad user
dns proxy = no
[share]
comment = Ubuntu File Server Share
path = /workspace/samba/share
browsable = yes
guest ok = yes
read only = no
create mask = 0755
min protocol = SMB2
client min protocol = SMB2
sudo systemctl restart smbd.service
sudo service firewall stop
smb://10.25.40.104/share/
smb://10.25.40.139/share/
smb://192.168.1.57/share/
exit 0
