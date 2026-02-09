#!/bin/bash
#set -xv

# See https://gehrcke.de/2019/10/freenas-insufficient-space-to-install-update-how-to-replace-the-usb-boot-device-with-a-larger-one/

USB key
Attach da1

/dev/da0p2/dev/da0p2

zpool status freenas-boot
1.56 G 2.12G

Boot Pool Condition: ONLINE
Size: 3.81 GiB
Used: 1.56 GiB

zpool set autoexpand=on freenas-boot
#zpool online -e freenas-boot da0p2
#Detach da0p2
zpool online -e freenas-boot da1p2

5.76 G

# See https://www.ixsystems.com/blog/how-to-install-truenas-core/

New SSD
ada4 50026B7784628000

zfs list

zpool get autoexpand freenas-boot
zfs list freenas-boot
zfs get space freenas-boot

----

Backup

/media/photo

----

zpool status
pool: dpool
state: ONLINE
scan: resilvered 12.0G in 5062 days 22:10:53 with 0 errors on Mon Nov 10 23:12:04 2025
config:

NAME STATE READ WRITE CKSUM
dpool ONLINE 0 0 0
raidz1-0 ONLINE 0 0 0
gptid/1332ddd2-fa15-11e2-ba6d-7c05070ed988.eli ONLINE 0 0 0
gptid/1390c35e-fa15-11e2-ba6d-7c05070ed988.eli ONLINE 0 0 0
gptid/13ef7751-fa15-11e2-ba6d-7c05070ed988.eli ONLINE 0 0 0
gptid/144d999a-fa15-11e2-ba6d-7c05070ed988.eli ONLINE 0 0 0

zpool offline zfs gptid/1332ddd2-fa15-11e2-ba6d-7c05070ed988.eli

geli detach

----

zpool status boot-pool

exit 0
