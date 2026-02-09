#!/bin/bash
set -xv

# See http://www.sleuthkit.org/

sudo apt install sleuthkit autopsy mac-robber

# See https://www.autopsy.com/download/

sudo apt-get install testdisk

sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
sudo apt-get update

sudo apt-get install build-essential autoconf libtool git-core
sudo apt-get build-dep imagemagick libmagickcore-dev libde265 libheif

cd /usr/src/
sudo git clone https://github.com/strukturag/libde265.git
sudo git clone https://github.com/strukturag/libheif.git
cd libde265/
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make install

cd /usr/src/libheif/
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make install

cd /usr/src/
sudo wget https://www.imagemagick.org/download/ImageMagick.tar.gz
sudo tar xf ImageMagick.tar.gz

cd ImageMagick-7*
sudo ./configure --with-heic=yes
sudo make
sudo make install

sudo ldconfig

#The BellSoft distribution bundles OpenJDK and OpenJFX.
wget -q -O - https://download.bell-sw.com/pki/GPG-KEY-bellsoft | sudo apt-key add -
echo "deb [arch=amd64] https://apt.bell-sw.com/ stable main" | sudo tee /etc/apt/sources.list.d/bellsoft.list

sudo apt-get update
sudo apt-get install bellsoft-java8-full

export JAVA_HOME=/usr/lib/jvm/bellsoft-java8-full-amd64
export PATH=$JAVA_HOME/bin:$PATH

#wget https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.10.0/sleuthkit-java_4.10.0-1_amd64.deb
sudo apt install ./sleuthkit-java_4.10.0-1_amd64.deb

wget https://github.com/sleuthkit/autopsy/releases/download/autopsy-4.16.0/autopsy-4.16.0.zip
unzip autopsy-4.16.0.zip
cd autopsy-4.16.0
sh unix_setup.sh

bin/autopsy

exit 0
