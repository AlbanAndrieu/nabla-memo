#!/bin/bash
tmpreaper --test 2d /tmp
nano /etc/rsyslog.d/50-default.conf
service rsyslog restart
exit 0
