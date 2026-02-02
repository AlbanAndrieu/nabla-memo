#!/bin/bash
set -xv
sudo apt-get install phantomjs
sudo apt-get install imagemagick
sudo npm install -g casperjs
​
sudo gem install wraith
wraith setup
wraith capture capture
open shots/gallery.html
