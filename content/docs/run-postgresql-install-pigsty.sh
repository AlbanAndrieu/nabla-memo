#!/bin/bash
set -xv
curl -fsSL https://repo.pigsty.io/get|  bash
                                              cd ~/pigsty
./bootstrap
             ./configure
                          ./install.yml
exit 0
