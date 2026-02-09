#!/bin/bash
set -xv

pkg update -f
pkg install npm
# pkg install www/npm

cd /usr/local/www/apache24/data/nabla
npm install
# ld-elf.so.1: /usr/local/bin/node: Undefined symbol "_ZNSt3__122__libcpp_verbose_abortEPKcz"

# https://forums.truenas.com/t/jails-for-version-13-3-have-daemon-command-broken-but-there-is-no-new-update-beside-13-0-u6-2-how-can-i-create-a-functional-jail-now/12444/22
# iocage upgrade -r 13.5-RELEASE [jail]

exit 0
