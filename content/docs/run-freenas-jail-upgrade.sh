#!/bin/bash
#set -xv

################# NOT WORKING ##########################
# version CXXABI_1.3.11 required by /usr/local/bin/mongo not found

# Fix:
# freebsd-update fetch
# freebsd-update upgrade -r 13.4-RELEASE
# freebsd-update install
# Updates cannot be installed when the system securelevel is greater than zero
# https://forums.freebsd.org/threads/cannot-upgrade-securelevel-greater-than-zero.79829/
# sysctl -n kern.securelevel
# reboot
# freebsd-update install
# uname -a

# https://www.truenas.com/download-truenas-core/
# https://forums.freebsd.org/threads/jail-with-newer-version-13-2-than-host-system-13-1.92067/

# TODO upgrade to TRUENAS SCALE

exit 0
