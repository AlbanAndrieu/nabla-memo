#!/bin/bash
set -xv

#cd /usr/ports/net-mgmt/collectd5/

cd /var/db/collectd/rrd/

# See https://collectd.org/wiki/index.php/Plugin:Write_Prometheus
#nano /conf/base/etc/local/collectd.conf
edit /etc/local/collectd.conf

LoadPlugin write_prometheus

<Plugin "write_prometheus">
  Port "9103"
</Plugin>

LoadPlugin network

<Plugin network>
  # proxy address
  Server "192.168.132.96" "8086"
</Plugin>

ls -lrta /usr/local/lib/collectd

service collectd onerestart

exit 0
