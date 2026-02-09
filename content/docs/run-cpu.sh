#!/bin/bash
set -xv

# See https://levelup.gitconnected.com/6-years-later-i-now-understand-my-laptops-cpu-specifications-ea87e3786b88

#### Fun Exercise: Check number of cores on CPU of your machine

# For Linux
nproc --all

# For MacOS
system_profiler SPHardwareDataType | grep "Cores"

# For Windows
Get-WmiObject -Class Win32_Processor | Select-Object NumberOfCores

#### logical cores

# For Linux
lscpu | grep -E "^Thread"

# For MacOS
sysctl -n hw.physicalcpu hw.logicalcpu

# For Windows (on Powershell)
Get-WmiObject -Class Win32_Processor | Select-Object NumberOfCores,NumberOfLogicalProcessors

#### Fun Exercise: Find out the cache sizes of your machine's CPU

# For Linux
lscpu | grep "cache"

# For MacOS
sysctl -n hw.l1icachesize hw.l1dcachesize hw.l2cachesize hw.l3cachesize

# For Windows (on Powershell)
wmic cpu get L2CacheSize, L3CacheSize

exit 0
