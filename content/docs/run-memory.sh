#!/bin/bash
set -xv
/sbin/sysctl vm.drop_caches=3
exit 0
