#!/bin/bash
set -xv

# See https://www.linuxtricks.fr/wiki/selinux-quelques-infos

sudo apt install policycoreutils
sestatus

less /etc/sysconfig/selinux

exit 0
