#!/bin/bash
set -xv
sudo apt-get install manpages-fr manpages-fr-extra manpages man-db manpages-posix
sudo apt install manpages-dev manpages-posix-dev
sudo apt-get install most
sudo update-alternatives --config pager
exit 0
