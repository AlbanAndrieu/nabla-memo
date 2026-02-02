#!/bin/bash
set -xv
sudo apt-get install apache2 php5 php5-common php-soap php5-gd
cd /tmp/&&  wget http://sourceforge.net/projects/phpvirtualbox/files/phpvirtualbox-4.3-1.zip
sudo service vboxweb status
exit 0
