#!/bin/bash
set -xv
lance svn
svnadmin create "C:\svn_repos"
svnserve --daemon --root "C:\svn_repos"
svn mkdir svn://localhost/project
svn mkdir svn://localhost/project/trunk
svn://localhost:3690
svn://localhost/
svn co svn://localhost/project/trunk/ .
svn import C:/workspace file:///C:\svn_repository -m "Initial import"
sudo apt-get update
sudo apt-get install rabbitvcs-nautilus
sudo apt-get install rabbitvcs-gedit
sudo apt-get install rabbitvcs-cli
nautilus -q
killall nautilus
svn copy svn://localhost/project/trunk \
  svn://localhost/project/tags/1.0 -m "Release 1.0"
svn changelist my-changelist tools/release_support/prepare_sdk_tarball.py
svn commit --changelist my-changelist
exit 0
