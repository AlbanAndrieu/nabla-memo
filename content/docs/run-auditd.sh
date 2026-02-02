#!/bin/bash
set -xv
sudo apt install auditd -y
sudo systemctl start auditd
sudo systemctl enable auditd
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
log_file = /var/log/audit/audit.log
max_log_file = 10
max_log_file_action = ROTATE
space_left = 75
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
0 3 * * * /home/albanandrieu/w/nabla/env/linux/run-audit-log-cleanup.sh > /var/log/cron-auditd-cleaning.log
nano /etc/zabbix/zabbix_agent2.conf
UserParameter=auditd.activity,sudo ausearch -k user_commands|  wc -l
version: '6.0'
chattr -i /var/log/audit/audit.log
ls -Zd /var/log/audit
/sbin/auditd -f
exit 0
