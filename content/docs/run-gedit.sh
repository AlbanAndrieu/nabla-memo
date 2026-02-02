#!/bin/bash
set -xv
cd /workspace
mkdir imitation-1.3
cd imitation-1.3
wget https://codetree.com.au/static/content/imitation/releases/imitation-1.3.tar.gz
tar -xvf imitation-1.3.tar.gz
cd imitation
sudo cp ../org.gnome.gedit.plugins.imitation.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas
cd ..
sudo cp -r imitation/ /usr/lib/gedit/plugins/
sudo cp imitation.plugin /usr/lib/gedit/plugins/
