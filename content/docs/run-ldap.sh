#!/bin/bash
set -xv
sudo apt-get install slapd ldap-utils migrationtools
sudo dpkg-reconfigure slapd
Omit OpenLDAP server configuration? ... No
DNS domain name: ... ldap.nabla.mobi
Name of your organization: ... nabla
Admin Password: microsoft
Confirm Password: microsoft
OK
BDB
Do you want your database to be removed when slapd is purged? ... No
Move old database? ... Yes
Allow LDAPv2 Protocol? ... No
ldapsearch -x -b dc=ldap,dc=nabla,dc=mobi
ldapsearch -x -h localhost -b "dc=ldap,dc=nabla,dc=mobi" "(objectClass=*)"
sudo apt-get install php5-ldap
sudo cp phpldapadmin-1.2.3.tgz /var/www/
sudo tar xvfz phpldapadmin-1.2.3.tgz
sudo mv phpldapadmin-1.2.3 phpldapadmin
cd /var/www/phpldapadmin/config
sudo mv config.php.example config.php
cd /var/www$
sudo ln -s /usr/share/phpldapadmin phpldapadmin
sudo /etc/init.d/apache2 restart
sudo service apache2 restart
cn=admin,dc=ldap,dc=nabla,dc=mobi
add a user albandri with password like the developer workstation
cd /opt/GoogleAppsDirSync
sudo ./config-manager
4/hITCFu3OkXtq96da9ysrgsMaFLlx.Eh-a-J3Bu7gXOl05ti8ZT3aRT0JKdgI
sudo dpkg-reconfigure ldap-auth-config
sudo service slapd status
