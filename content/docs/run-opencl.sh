#!/bin/bash
set -xv
cd ~/Downloads/
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1_x64_ubuntu_5.2.0.10002.tgz
cd opencl_runtime_16.1_x64_ubuntu_5.2.0.10002
sudo sh install.sh
sudo mkdir /opt/intel
sudo tar -xzf opencl-1.2.0.9756.tgz -C /opt/intel
sudo mkdir -p /etc/OpenCL/vendors
sudo ln -s /opt/intel/opencl-1.2.0.9756/etc/intel64.icd /etc/OpenCL/vendors/intel64.icd
sudo apt-get install ocl-icd-libopencl1 ocl-icd-opencl-dev libnuma-dev
ll /etc/X11/xorg.conf
Section "Device"
Identifier "Device0"
Driver "nvidia"
VendorName "NVIDIA Corporation"
Option "Interactive" "off"
EndSection
cat /proc/cpuinfo
lspci|  grep NVIDIA
sudo apt-get install clinfo
clinfo
sudo apt-get install opencl-headers
sudo apt-get install beignet beignet-dev
exit 0
