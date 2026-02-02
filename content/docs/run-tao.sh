#!/bin/bash
set -xv
cd $ACE_ROOT
make
ls -lrta /usr/local/share/ace
cd $TAO_ROOT
make
exit 0
