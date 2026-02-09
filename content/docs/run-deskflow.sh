#!/bin/bash
set -xv

# https://github.com/deskflow/deskflow

# To replace
# ./run-barrier.sh

# NOK wget https://github.com/deskflow/deskflow/releases/download/continuous/deskflow-continuous-ubuntu-plucky-x86_64.deb
# NOK wget https://github.com/deskflow/deskflow/releases/download/v1.22.0/deskflow-1.22.0-ubuntu-plucky-x86_64.deb
# The following packages have unmet dependencies:
#  deskflow: Depends: libportal1 (>= 0.8.0) but 0.7.1-5build5 is to be installed
#            Depends: libqt6core6t64 (>= 6.8.2) but 6.4.2+dfsg-21.1build5 is to be installed
#            Depends: libqt6gui6 (>= 6.7.2)
#            Depends: libqt6widgets6 (>= 6.8.2)
#            Depends: libqt6xml6 (>= 6.6.0)
#            Depends: libxtst6 (>= 2:1.2.5) but 2:1.2.3-1.1build1 is to be installed

# NOK brew install deskflow

# Use flatpak
flatpak install flathub org.deskflow.deskflow

sudo apt install wl-clipboard

exit 0
