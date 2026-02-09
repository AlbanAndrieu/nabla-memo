#!/bin/bash
set -xv

# See https://medium.com/devsecops-community/why-auditd-is-the-secret-weapon-for-efficient-linux-management-4b2c3bffe9fc

sudo apt install auditd -y
sudo systemctl start auditd
sudo systemctl enable auditd

# As root

auditctl -s

auditctl -w /var/log/secure -p r -k login_attempts
auditctl -a always,exit -F arch=b64 -S execve -k user_commands
auditctl -w /var/log/auth.log -p w -k privilege_escalation
auditctl -w /etc/passwd -p wa -k passwd_changes

nano /etc/audit/rules.d/audit.rules
-w /var/log/secure -p r -k login_attempts
-a always,exit -F arch=b64 -S execve -k user_commands
-w /var/log/auth.log -p w -k privilege_escalation
-w /etc/passwd -p wa -k passwd_changes

sudo systemctl restart auditd

nano /etc/audit/auditd.conf
# Location of the audit log file
log_file = /var/log/audit/audit.log

# Max log file size in MB
max_log_file = 10

# Action to take when max size is reached
max_log_file_action = ROTATE

# Space threshold in MB to trigger an alert
space_left = 75

# Critical space threshold in MB for admin alert
admin_space_left = 50

sudo crontab -e
0 0 1 * * rm -f /var/log/audit/audit.log.*

ausearch -k login_attempts
ausearch -k user_commands

aureport -x
aureport -u

nano /etc/audit/auditd.conf
action_mail_acct = root

log_format = RAW remote_server = 172.17.0.24

0 3 * * * /home/albanandrieu/w/nabla/env/linux/run-audit-log-cleanup.sh >/var/log/cron-auditd-cleaning.log

# See https://medium.com/devsecops-community/how-do-you-find-out-who-changed-the-configuration-with-the-exact-details-ab5819542715

nano /etc/zabbix/zabbix_agent2.conf
UserParameter=auditd.activity,sudo ausearch -k user_commands | wc -l

# Get https://github.com/karthick-dkk/zabbix/tree/main/templates
version: '6.0'
# template_groups:
#   - uuid: 846977d1dfed4968bc5f8bdb363285bc
#     name: 'Templates/Operating systems'

# sudo apt install policycoreutils
# restorecon -Rv /var/log/audit/
# chattr +i /var/log/audit/audit.log
chattr -i /var/log/audit/audit.log

ls -Zd /var/log/audit

/sbin/auditd -f

exit 0
