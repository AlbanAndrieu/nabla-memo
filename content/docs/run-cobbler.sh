#!/bin/bash
set -xv
apt-get install make
apt-get install git
apt-get install python-yaml
apt-get install python-cheetah
apt-get install python-netaddr
apt-get install python-simplejson
apt-get install libapache2-mod-wsgi
apt-get install python-django
apt-get install atftpd
ln -s /srv/tftp /var/lib/tftpboot
chown www-data /var/lib/cobbler/webui_sessions
apt-get install cobbler cobbler-web
systemctl start cobblerd.service
a2dismod python
cp /etc/cobbler/cobbler.conf /etc/apache2/conf.d/cobbler.conf
service apache2 restart
exit 0
