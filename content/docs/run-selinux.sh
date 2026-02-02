#!/bin/bash
set -xv
sudo apt install policycoreutils
sestatus
less /etc/sysconfig/selinux
exit 0
