#!/bin/bash
set -xv
pkg update -f
pkg install npm
cd /usr/local/www/apache24/data/nabla
npm install
exit 0
