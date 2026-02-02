#!/bin/bash
set -xv

sudo visudo

# In the bottom of the file, add the following line:
albanandrieu ALL=(ALL) NOPASSWD: ALL
# <user> ALL = NOPASSWD: <install prefix>/sbin/openvas
ubuntu ALL = NOPASSWD: /usr/sbin/openvas
ubuntu ALL = NOPASSWD: /usr/bin/zenmap

# Add this line at the end to require the password after 5 minutes:
Defaults timestamp_timeout=50

exit 0
