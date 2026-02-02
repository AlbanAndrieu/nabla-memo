#!/bin/bash
set -xv
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-solstudio-cookie" wget http://download.oracle.com/otn/solaris/studio/SolarisStudio12.3-solaris-sparc-bin.tar.bz2 -O SolarisStudio12.3-solaris-sparc-bin.tar.bz2
scp SolarisStudio12.3-solaris-sparc-pkg.tar.bz2 root@nabla:/var/www/html/download/sunstudio/12.3
bzcat SolarisStudio12.3-solaris-sparc-pkg.tar.bz2|  /bin/tar -xf -
cd SolarisStudio12.3-solaris-sparc-pkg
sudo su - root
./solarisstudio.sh --help
./solarisstudio.sh --non-interactive --javahome /usr/jdk/instances/jdk1.8.0_131 --verbose
ls -ld /opt/solarisstudio12.3
cd /opt
ln -s /opt/solarisstudio12.3 /opt/SUNWspro
