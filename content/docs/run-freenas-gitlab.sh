#!/bin/bash
set -xv
pkg install gitlab-ce
sysrc gitlab_enable=YES
service gitlab restart
http://10.20.0.120
cd /usr/local/www/gilab-ce
Database Name: gitlabhq_production
Database User: git
Database Password: XXX
Please open the URL to set your password, Login Name is root.
/usr/local/www/gitlab-workhorse
exit 0
