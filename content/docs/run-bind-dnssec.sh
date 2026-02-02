#!/bin/bash
set -xv
sudo nano /etc/bind/named.conf.options
dnssec-enable yes
dnssec-validation yes
dnssec-lookaside auto
exit 0
