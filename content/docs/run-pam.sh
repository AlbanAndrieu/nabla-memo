#!/bin/bash
#set -x

#Disable kerberos
echo "pam -auth-update"

# ./run-otp-2fa.sh
# ./run-webauthn.sh

# change pam and disable pam_sss (smart card)
# SSS authentication
# sudo apt remove sssd libpam-sss

sudo pam-auth-update

# reset pam
# dpkg -S /etc/pam.d/*
sudo apt install --reinstall -o Dpkg::Options::="--force-confmiss" $(dpkg -S /etc/pam.d/\* | cut -d ':' -f 1)

sudo apt remove libpam-passwdqc libpam-u2
# check pwquality
sudo faillock --user albandrieu

sudo geany /etc/pam.d/common-auth

# there is no
# line 16
auth required pam_faillock.so preauth
# line 22
auth sufficient pam_faillock.so authsucc

# See https://ubuntu.com/server/docs/smart-card-authentication
# To use smart-card authentication with fallback
# sudo pam-auth-update --disable sss-smart-card-required --enable sss-smart-card-optiona

----------------------
auth required pam_faillock.so preauth
# here are the per-package modules (the "Primary" block)
auth [success=4 default=ignore] /usr/lib/security/howdy/pam_howdy.so
auth [success=3 default=ignore] pam_fprintd.so max-tries=1 timeout=10 # debug
auth [success=2 default=ignore] pam_unix.so nullok try_first_pass
auth [success=1 default=ignore] pam_sss.so use_first_pass
# here's the fallback if no module succeeds
auth requisite pam_deny.so
# prime the stack with a positive return value if there isn't one already;
# this avoids us returning an error just because nothing sets a success code
# since the modules above will each just jump around
auth required pam_permit.so
# and here are more per-package modules (the "Additional" block)
auth required pam_ecryptfs.so unwrap
auth optional pam_cap.so
# end of pam-auth-update config
----------------------------

# https://documentation.ubuntu.com/server/how-to/security/smart-card-authentication/index.html#id4
sudo apt install pamtester

exit 0
