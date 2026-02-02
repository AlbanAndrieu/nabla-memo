#!/bin/bash
set -xv
sudo apt-get remove xdot libcdt4 libcdt5 libpathplan4 libxdot4
sudo apt-get install gdebi
sudo wget http://www.graphviz.org/pub/graphviz/stable/ubuntu/ub13.10/x86_64/graphviz_2.38.0-1~saucy_amd64.deb
sudo wget http://www.graphviz.org/pub/graphviz/stable/ubuntu/ub13.10/x86_64/libgraphviz4_2.38.0-1~saucy_amd64.deb
sudo gdebi libgraphviz4_2.38.0-1~saucy_amd64.deb
sudo gdebi graphviz_2.38.0-1~saucy_amd64.deb
dot -Tcmapx
sudo dot -v
sudo dot -c
exit 0
