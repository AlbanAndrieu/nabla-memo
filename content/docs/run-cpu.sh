#!/bin/bash
set -xv
nproc --all
system_profiler SPHardwareDataType|  grep "Cores"
Get-WmiObject -Class Win32_Processor|  Select-Object NumberOfCores
lscpu|  grep -E "^Thread"
sysctl -n hw.physicalcpu hw.logicalcpu
Get-WmiObject -Class Win32_Processor|  Select-Object NumberOfCores,NumberOfLogicalProcessors
lscpu|  grep "cache"
sysctl -n hw.l1icachesize hw.l1dcachesize hw.l2cachesize hw.l3cachesize
wmic cpu get L2CacheSize, L3CacheSize
exit 0
