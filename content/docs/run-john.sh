#!/bin/bash
set -xv
sudo apt install john
unshadow /etc/passwd /etc/shadow > mypasswd.txt
john mypasswd.txt
john --show mypasswd.txt
exit 0
