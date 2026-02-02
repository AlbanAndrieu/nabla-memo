#!/bin/bash
set -xv

# https://www.ossec.net/docs/docs/manual/installation/installation-package.html

sudo apt-get install build-essential make zlib1g-dev libpcre2-dev libevent-dev libssl-dev

wget -q -O - https://updates.atomicorp.com/installers/atomic | sudo bash
sudo apt-get update
sudo apt-get install ossec-hids-server

sudo /var/ossec/bin/ossec-control start

# sudo apt-get install ossec-hids-agent

# https://computingpost.medium.com/how-to-install-ossec-hids-on-ubuntu-18-04-16-04-debian-9-e775bb5c92c7

cd ~/w/jm/github
git clone https://github.com/ossec/ossec-wui.git
sudo mv ossec-wui /srv


#  ossec ERROR: Could not find htpasswd. No password set
sudo apt-get install apache2-utils
which htpasswd

nabla
pwdbla
www-data

sudo geany /etc/apache2/sites-enabled/ossec-wui.conf
<VirtualHost *:8080>

	ServerName ossec.example.com
	ServerAlias www.ossec.example.com

	ServerAdmin admin@example.com

	DocumentRoot /srv/ossec-wui/

	Options +FollowSymlinks

    <Directory "/srv/ossec-wui/">
		AllowOverride All
		# Order allow,deny
		# Allow from all
		Require all granted
    </Directory>

	ErrorLog /var/log/apache2/moodle-error.log
	CustomLog /var/log/apache2/moodle-access.log combined
</VirtualHost>

cd /srv/ossec-wui
chmod 644 .htaccess

#sudo chgrp -R www-data ./
sudo chown -R albanandrieu:www-data ./
sudo chown -R www-data:www-data ./
find ./ -type d -exec chmod 755 -R {} \;
find ./ -type f -exec chmod 644 {} \;

echo "http://localhost:8080/"

exit 0
