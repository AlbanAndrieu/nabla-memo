#!/bin/bash
set -xv

# https://www.digitalocean.com/community/tutorials/how-to-setup-dnssec-on-an-authoritative-bind-dns-server-2

sudo nano /etc/bind/named.conf.options
dnssec-enable yes
dnssec-validation yes
dnssec-lookaside auto

exit 0
