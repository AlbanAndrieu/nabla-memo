#!/bin/bash
set -xv
sudo apt-get install libdb4.2-ruby1.8 libcairo-ruby1.8
sudo wget http://production.cf.rubygems.org/rubygems/rubygems-1.4.2.tgz
sudo tar -xvf rubygems-1.4.2.tgz
cd rubygems-1.4.2
sudo ruby setup.rb install
cd ..
sudo rm -rf rubygems-1.4.2
sudo ln -s /usr/bin/gem1.8 /usr/local/bin/gem
gem sources -a http://gems.github.com
sudo apt-get install python-software-properties
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
ruby -v
sudo apt-get install ruby1.8 ruby-switch
sudo gem1.8 install cairo
sudo dpkg -l|  grep ruby
sudo aptitude remove ruby1.9.1
sudo apt-get install ruby ruby-cairo
sudo gedit /usr/lib/cgi-bin/philesight.cgi
$path_db = "/usr/lib/philesight.db"
cd /workspace/users/
sudo chmod 750 images
sudo chmod 750 albandri33
