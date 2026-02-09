#!/bin/bash
set -xv

# hack
# See https://askubuntu.com/questions/383057/how-to-decode-the-hash-password-in-etc-shadow
sudo apt install john
unshadow /etc/passwd /etc/shadow >mypasswd.txt
john mypasswd.txt
john --show mypasswd.txt

exit 0
