#!/bin/bash
set -xv
ssh -X root@nabla
iocage list -l
iocage destroy homeassistant
iocage df
iocage fetch
[0] 13.4-RELEASE
[1] 13.5-RELEASE
[2] 14.1-RELEASE
[3] 14.2-RELEASE
Choose 1
iocage restart jenkins
/sbin/umount -f /mnt/dpool/iocage/jails/jenkins/root/media/jenkins
df -h|  grep -v RELEASE|  grep -v devfs|  grep -v fdescfs|  grep -v system
iocage update clamav
iocage update grafana
iocage update graylog
./run-freenas-sonarr.sh
./run-freenas-radarr.sh
./run-freenas-jackett.sh
exit 0
