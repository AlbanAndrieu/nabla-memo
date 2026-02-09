#!/bin/bash
#set -xv
#set -eo pipefail

# https://www.ntop.org/guides/ntopng/third_party_integrations/pfsense.html
# https://packages.ntop.org/FreeBSD/
pkg add https://packages.ntop.org/FreeBSD/FreeBSD:15:aarch64/latest/ntop-1.0.pkg
# NOK not available for aarch64

# bsd

pkg add https://packages.ntop.org/FreeBSD/FreeBSD:13:amd64/latest/ntop-1.0.pkg
pkg install nprobe

#https://www.ntop.org/guides/nprobe/how_to_start.html

/usr/local/bin/nprobe

nprobe --zmq tcp://*:1234 --ips-mode /etc/nprobe/ips-rules.conf -i nf:0

exit 0
