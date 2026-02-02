#!/bin/bash
set -euo pipefail

# MySQL Installation and Configuration Script
# See http://doc.ubuntu-fr.org/mysql

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-}"
DEBUG="${DEBUG:-0}"

# Enable debug mode if DEBUG is set
if [[ "${DEBUG}" == "1" ]]; then
    set -xv
fi

# Trap handler for errors
trap 'echo "❌ Error on line ${LINENO}" >&2' ERR
sudo apt-get install mysql-server-5.7
#http://doc.ubuntu-fr.org/lamp
#apache on http://127.0.1.1:80
#check php http://localhost/test.php

#https://home.nabla.mobi/phpmyadmin/

sudo service mysql start

sudo service mysql force-reload

#default user : root/admin
#sudo mysqladmin -u root password Nouveau_mot_de_passe -p Ancien_mot_de_passe
sudo mysqladmin -u user_name -h host_name password "newpwd"
sudo mysqladmin -u nabla -h localhost password "nabla"
sudo mysqladmin -u root -h localhost password "microsoft"

GRANT SUPER ON *.* TO nabla@'localhost' IDENTIFIED BY 'nabla';

#/etc/mysql/
#/var/lib/mysql/

#change password
/etc/init.d/mysql stop
#relaunch
sudo mysqld --skip-grant-tables --skip-networking &
#database connection
mysql mysql
UPDATE user SET password=PASSWORD('microsoft') WHERE User="root" AND Host="localhost";

#test connection
mysql -u root -p

#pid bug
cd /var/run/mysqld/
sudo chmod 664 mysqld.pid
#inside /etc/init.d/mysql
    #pidfile=`mysqld_get_param pid-file`
    pidfile="/var/run/mysqld/mysqld.pid"
    echo "pidfile = $pidfile"

#remove mysql
#See run-mysql-remove.sh

#check connection from outside
#from inside
telnet localhost 3306
#from outside
telnet 10.21.22.69 3306
mysql -u root --password=Motdepass12 -h 10.21.22.69 mysql

sudo netstat -ntlup | grep mysql
#bind-address=YOUR-SERVER-IP
#Try to add bind-address = 0.0.0.0 to your [mysqld] section of your my.cnf and restart mysqld.
sudo nano /etc/mysql/my.cnf

#sonar timeout fixes
sudo nano /etc/mysql/my.cnf
interactive_timeout = 28800
wait_timeout = 28800
