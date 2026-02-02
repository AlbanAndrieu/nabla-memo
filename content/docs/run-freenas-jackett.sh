#!/bin/bash
iocage list -b
echo '{"pkgs":["mono","curl","ca_root_nss"]}' > /tmp/pkg.json
iocage create -n "jackett" -p /tmp/pkg.json -r 11.3-RELEASE ip4_addr="vnet0|172.16.0.27/30" defaultrouter="172.16.0.1" vnet="on" \
  nat_forwards='tcp(9117)' \
  nat="on" allow_raw_sockets="1" boot="on" --basejail
rm /tmp/pkg.json
iocage exec jackett mkdir -p /config
iocage fstab -a jackett /mnt/dpool/apps/jackett /config nullfs rw 0 0
iocage exec jackett "fetch https://github.com/Jackett/Jackett/releases/download/v0.14.99/Jackett.Binaries.Mono.tar.gz -o /usr/local/share"
iocage exec jackett "tar -xzvf /usr/local/share/Jackett.Binaries.Mono.tar.gz -C /usr/local/share"
iocage exec jackett rm /usr/local/share/Jackett.Binaries.Mono.tar.gz
iocage exec jackett "pw user add jackett -c jackett -u 818 -d /nonexistent -s /usr/bin/nologin"
iocage exec jackett chown -R jackett:jackett /usr/local/share/Jackett /config
iocage exec jackett mkdir /usr/local/etc/rc.d
nano /mnt/dpool/iocage/jails/jackett/root/usr/local/etc/rc.d/jackett
iocage exec jackett chmod u+x /usr/local/etc/rc.d/jackett
iocage exec jackett sysrc "jackett_enable=YES"
iocage exec jackett service jackett restart
Jackett should be available at http://192.168.1.24:9117
iocage df
exit
