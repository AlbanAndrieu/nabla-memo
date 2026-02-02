#!/bin/bash
set -xv
pkginfo|  grep SUNWopensslr
pkginfo -l SUNWopensslr
/usr/sfw/bin/openssl version
pkgchk -l SUNWopenssl-libraries
pkgadd -d
patchadd /var/spool/patch/123456-07
148072-19 SunOS 5.10_x86: openssl patch
151913-02 Obsoleted by: 151913-03 SunOS 5.10_x86: OpenSSL 1.0.1 patch
zoneadm list -vc
