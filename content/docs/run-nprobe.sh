#!/bin/bash
pkg add https://packages.ntop.org/FreeBSD/FreeBSD:15:aarch64/latest/ntop-1.0.pkg
pkg add https://packages.ntop.org/FreeBSD/FreeBSD:13:amd64/latest/ntop-1.0.pkg
pkg install nprobe
/usr/local/bin/nprobe
nprobe --zmq tcp://*:1234 --ips-mode /etc/nprobe/ips-rules.conf -i nf:0
exit 0
