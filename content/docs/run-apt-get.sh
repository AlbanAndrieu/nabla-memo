#!/bin/bash
sudo geany /etc/apt/sources.list
ls /etc/apt/sources.list.d/
sudo mkdir -p /workspace/users/albandri30
sudo mkdir -p /workspace/users/albandri10
sudo chown albandri:albandri -R /workspace
sudo apt-get autoremove
sudo apt-get install nis ntp autofs
sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
sudo apt-get -f install
sudo apt-get install vim dos2unix xxdiff
sudo apt-get install wget curl nmap ssh
sudo apt-get install smartmontools mon
sudo apt-get install cmake scons
sudo apt-get install doxygen graphviz
sudo apt-get install ssmtp mailutils
sudo apt-get install geany gedit
sudo cpan install CPAN
sudo cpan install BDB
sudo cpan install XML::DOM
sudo cpan install XML::Handler::YAWriter
sudo cpan install XML::Simple
sudo cpan install Test::Harness
sudo cpan install Test::Pod::Coverage
sudo cpan install Test::Pod
sudo cpan install JSON
sudo cpan install IO::Prompt
sudo cpan install Text::SimpleTable
sudo cpan install HTTP::Date
sudo cpan install Date::Calc
sudo cpan install Date::Format
sudo cpan install Date::Manip
sudo cpan install LWP::Protocol::https
sudo cpan install Crypt::SSLeay
sudo cpan install File::Copy::Recursive
sudo cpan install File::Find::Rule
sudo cpan install Tree::Simple
sudo cpan install Tree::Simple::View::ASCII
sudo apt-get autoclean
sudo apt-get update
sudo apt-get install subversion
sudo apt-get install python-pip python-dev build-essential
sudo pip install --upgrade pip
sudo nano /etc/ssh/sshd_config
ForwardX11Trusted yes
less /var/log/boot.log
more /etc/rc.local
ls /etc/rc?.d
rc0.d contains the services which runs in runlevel 0
rc1.d contains the services which runs in runlevel 1
rc2.d contains the services which runs in runlevel 2
rc3.d contains the services which runs in runlevel 3
rc4.d contains the services which runs in runlevel 4
rc5.d contains the services which runs in runlevel 5
rc6.d contains the services which runs in runlevel 6
sudo update-rc.d -n varnish start 85 2 3 4 5 . stop 20 0 1 6 .
sudo update-rc.d -n private-bower start 85 2 3 4 5 . stop 20 0 1 6 .
sudo update-rc.d -n apache2 start 80 2 3 4 5 . stop 25 0 1 6 .
sudo update-rc.d -f varnish remove
sudo update-rc.d varnish start 85 2 3 4 5 . stop 20 0 1 6 .
sudo update-rc.d -f varnishlog remove
sudo update-rc.d -n varnishlog start 85 2 3 4 5 . stop 20 0 1 6 .
sudo update-rc.d -f varnishncsa remove
sudo update-rc.d -n varnishncsa start 85 2 3 4 5 . stop 20 0 1 6 .
sudo update-rc.d -f apache2 remove
sudo update-rc.d apache2 start 80 2 3 4 5 . stop 25 0 1 6 .
xhost +
ifconfig eth0
id -u
sudo apt-get install zabbix-agent
sudo apt-get install snmp snmpd
sudo nano /etc/dhcp/dhclient.conf
append domain-name " nabla.mobi"
sudo dhclient
sudo apt-get install aptitude
sudo apt install cowsay fortunes fortunes-fr
brew install randomize-lines
sudo apt-get remove whoopsie
sudo chown -R albandri:albandri ~/.putty
sudo apt-get install lcov
sudo apt-get install meld
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop
cat /proc/sys/vm/swappiness
gksu gedit /etc/sysctl.conf
cat /proc/sys/vm/swappiness
sudo apt-get install ubuntu-restricted-extras
sudo apt-get remove --auto-remove icinga
sudo apt-get remove icinga-web
sudo apt-get --purge remove tex.\*-doc$
sudo rm -Rf /usr/share/doc/texlive-doc/
sudo rm -Rf /var/lib/jenkins/tmp
sudo find /var/log -name '*.gz'|  xargs sudo rm -r $1
sudo apt-get clean
sudo apt-file search /usr/bin/netstat
sudo apt-get source net-tools
aptitude safe-upgrade
aptitude forbid-version my_packet=X.Y
sudo apt-get install apticron
fuser -v /bin/bash
sudo apt-get  install lsb-core
lsb_release -a
lsmod
sudo modinfo btrfs
dpkg --get-selections > installed-packages
sudo apt-get install iperf
sudo lspci -nnk|  grep VGA -A1
sudo lspci -v|  grep -A7 -i "audio"
sudo lspci -nnk|  grep net -A2
sudo lshw -short
sudo lshw -html > lshw.html
sudo apt-get remove usbmount
sudo chmod 644 /lib/systemd/system/tomcat7.service
sudo apt-get install software-center*
sudo chmod -x /usr/lib/x86_64-linux-gnu/hud/hud-service
sudo apt-get install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
sudo update-rc.d -f nexus remove
sudo systemctl enable nexus.service
sudo nano /etc/default/grub
sudo update-grub
ps -p 1 -o comm=
systemd-analyze time
systemd-analyze blame
systemd-analyze critical-chain
systemd-analyze plot > plot.svg
eog plot.svg
sudo service apparmor stop
sudo update-rc.d -f apparmor remove
sudo apt-get remove apparmor apparmor-utils
sudo ua attach $UBUNTU_ADVANTAGE_TOKEN
sudo apt-get install terminator
exit 0
