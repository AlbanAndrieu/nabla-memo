#!/bin/bash
set -xv
systemctl status cron
/usr/bin/flock -n /tmp/fcj.lockfile /usr/bin/rm -f backup-*.snap&&  /usr/local/bin/consul snapshot save backup-$HOSTNAME-$(  date +\%Y-\%m-\%d).snap&&  /usr/bin/s3cmd put -c ~/.s3cfg_scaleway_fr_par --recursive --no-progress --no-preserve backup-$HOSTNAME-*.snap   s3://ovh-replica/vault/
exit 0
