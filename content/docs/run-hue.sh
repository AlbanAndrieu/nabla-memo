#!/bin/bash
pip install phue
sudo apt-get install extra-cmake-modules
sudo apt-get install qt5-default
sudo apt-get install qtbase5-dev
sudo apt-get install qtdeclarative5-dev
sudo apt-get install qtmultimedia5-dev
sudo apt-get install qt-quickcontrols2-5-dev
sudo apt-get install libqt5remoteobjects5-dev libqt5remoteobjects5-bin
ls -lrta /usr/lib/x86_64-linux-gnu/cmake/Qt5RemoteObjects/
qtchooser -print-env
qmake -v
git clone --recursive git://github.com/BradyBrenot/huestacean.git
cd huestacean
git checkout tags/v2.6 -b test-v2.6
git submodule sync
mkdir build
cd build
cmake ..
make
make huestacean
exit 0
