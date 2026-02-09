#!/bin/bash
set -xv

# See https://gitlab.fechner.net/mfechner/Gitlab-docu/-/blob/master/install/12.2-freebsd.md

pkg install gitlab-ce
sysrc gitlab_enable=YES

service gitlab restart

#pkg install postgresql13-server postgresql13-contrib

# https://gitlab.fechner.net/mfechner/Gitlab-docu/-/tree/master

http://10.20.0.120

cd /usr/local/www/gilab-ce

Database Name: gitlabhq_production
Database User: git
Database Password: XXX

Please open the URL to set your password, Login Name is root.

/usr/local/www/gitlab-workhorse

exit 0
