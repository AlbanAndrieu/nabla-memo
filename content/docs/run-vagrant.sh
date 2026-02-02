#!/bin/bash
set -xv
cd /workspace
sudo wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.3_i686.deb
sudo dpkg --install vagrant_1.4.3_i686.deb
git clone https://github.com/leucos/ansible-tuto.git
cd ansible-tuto
vagrant up
vagrant init base
vagrant up
vagrant ssh
vagrant rdp
vagrant provision
vagrant halt
vagrant destroy
vagrant package --base 'vagrant-windows-2012' --output 'vagrant-windows-2012.box'
sudo apt-get install libxslt-dev libxml2-dev libvirt-dev
sudo vagrant plugin install vagrant-libvirt vagrant-login vagrant-share vagrant-winrm
sudo vagrant plugin uninstall vagrant-windows
sudo vagrant plugin uninstall vagrant-lxc
sudo vagrant plugin uninstall vagrant-vbguest
sudo vagrant plugin list
sudo vagrant plugin update
