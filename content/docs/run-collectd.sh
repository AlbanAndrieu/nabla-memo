#!/bin/bash
set -xv
/opt/collectd/etc/collectd.conf
cd /opt/collectd/var/log
gksudo geany /etc/collectd/collectd.conf
sudo /usr/sbin/collectdmon -P /var/run/collectd.pid -- -C /etc/collectd/collectd.conf
sudo tail -f /var/log/upstart/collectd.log
exit 0
