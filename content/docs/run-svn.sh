#!/bin/bash
set -xv

#http://ericreboisson.developpez.com/tutoriels/install-subversion/
lance svn
#svnserve -d

#sc create svn binpath= "\"C:\Program Files (x86)\CollabNet\Subversion%20Server\svnserve.exe\" --service -r C:\svn_repository" displayname= "Subversion Server" depend= Tcpip start= auto

svnadmin create "C:\svn_repos"
svnserve --daemon --root "C:\svn_repos"
svn mkdir svn://localhost/project
svn mkdir svn://localhost/project/trunk

svn://localhost:3690
svn://localhost/

svn co svn://localhost/project/trunk/ .

svn import C:/workspace file:///C:\svn_repository -m "Initial import"

#SVN
#sudo apt-get install python-nautilus python-configobj python-gtk2 python-glade2 python-svn python-dbus python-dulwich subversion meld
#sudo add-apt-repository ppa:rabbitvcs/ppa
#deb http://ppa.launchpad.net/rabbitvcs/ppa/ubuntu precise main
sudo apt-get update
sudo apt-get install rabbitvcs-nautilus
sudo apt-get install rabbitvcs-gedit
sudo apt-get install rabbitvcs-cli

#Restart Nautilus Without Log Out
nautilus -q
killall nautilus

# Tag
svn copy svn://localhost/project/trunk \
  svn://localhost/project/tags/1.0 -m "Release 1.0"

svn changelist my-changelist tools/release_support/prepare_sdk_tarball.py
svn commit --changelist my-changelist

exit 0
