#!/bin/bash
echo "pam -auth-update"
sudo pam-auth-update
sudo apt install --reinstall -o Dpkg::Options::="--force-confmiss" $(dpkg -S /etc/pam.d/\*|  cut -d ':' -f 1)
sudo apt remove libpam-passwdqc libpam-u2
sudo faillock --user albandrieu
sudo geany /etc/pam.d/common-auth
auth required pam_faillock.so preauth
auth sufficient pam_faillock.so authsucc
----------------------
auth required pam_faillock.so preauth
auth [success=4 default=ignore] /usr/lib/security/howdy/pam_howdy.so
auth [success=3 default=ignore] pam_fprintd.so max-tries=1 timeout=10
auth [success=2 default=ignore] pam_unix.so nullok try_first_pass
auth [success=1 default=ignore] pam_sss.so use_first_pass
auth requisite pam_deny.so
auth required pam_permit.so
auth required pam_ecryptfs.so unwrap
auth optional pam_cap.so
----------------------------
sudo apt install pamtester
exit 0
