#!/bin/bash
set -xv

#See https://doc.ubuntu-fr.org/nvidia
#https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-19-04-disco-dingo-linux
#https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-19-10-eoan-ermine-linux

# sudo apt remove --purge nvidia-driver-435 nvidia-driver-440
sudo apt-get autoremove --purge nvidia-driver-*
sudo apt-get autoremove --purge nvidia-*
sudo apt-get remove nvidia-cuda-*
sudo apt-get autoremove --purge xserver-xorg-video-nouveau

ubuntu-drivers devices
#== /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0 ==
#modalias : pci:v000010DEd00001F08sv00001043sd0000868Ebc03sc00i00
#vendor   : NVIDIA Corporation
#model    : TU106 [GeForce RTX 2060 Rev. A]
#driver   : nvidia-driver-435 - distro non-free recommended
#driver   : nvidia-driver-430 - distro non-free
#driver   : xserver-xorg-video-nouveau - distro free builtin

# Check for the Available Nvidia Drivers
apt search nvidia-driver*
#nvidia-driver-435/eoan,now 435.21-0ubuntu2 amd64 [installed]

sudo apt-get install nvidia-driver-460 nvidia-settings
sudo apt install nvidia-utils-470 nvidia-settings # Ubuntu 21 for albandrieu taff
# ubuntu 20
# 495
# ubuntu 22
sudo apt-get install nvidia-driver-535 nvidia-settings
# ubuntu 23
# sudo apt-get install nvidia-driver-525 nvidia-settings
# ubuntu 23
sudo apt-get install nvidia-driver-535 nvidia-settings
# ubuntu 24
sudo add-apt-repository ppa:graphics-drivers/ppa
# ubuntu 24 with 6.8.0-31-generic
sudo apt remove nvidia-kernel-common-580 nvidia-firmware-580
rm  /usr/share/nvidia.nvidia-application-profiles-580.126.09-key-documentation
sudo apt --fix-broken install
sudo apt install nvidia-driver-580 nvidia-settings # xserver-xorg-video-nvidia-580 nvidia-driver-pinning-580

lspci | grep VGA
# 00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630] (rev 02)
# 01:00.0 VGA compatible controller: NVIDIA Corporation TU106 [GeForce RTX 2060 Rev. A] (rev a1)
lspci | grep -i nvidia

nvidia-detector
# nvidia-driver-580

# https://forums.developer.nvidia.com/t/gpu-driver-doesnt-work-properly-on-ubuntu-24-04-lts/294208/3

sudo apt install nvidia-utils-580
nvidia-xconfig
# ERROR: Unable to find any GPUs in the system

# https://forums.developer.nvidia.com/t/error-nvidia-settings-could-not-find-the-registry-key-file/50142/3
cd /usr/share/nvidia
#sudo ln -s nvidia-application-profiles-535.171.04-key-documentation nvidia-application-profiles-key-documentation
sudo ln -s nvidia-application-profiles-580.126.09-key-documentation nvidia-application-profiles-key-documentation

dkms status
#nvidia/550.107.02: added
#ovpn-dco/0-20220601git2db65af, 5.4.0-120-generic, x86_64: installed
#ovpn-dco/0-20220601git2db65af, 5.4.0-121-generic, x86_64: installed
# ISSUE with ovpn-dco, kernel not building

sudo apt install nvidia-cuda-toolkit
nvcc --version
# NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver. Make sure that the latest NVIDIA driver is installed and running.
# Fix it by adding
sudo apt-get install linux-headers-$(uname -r)

# The doing :
cd /workspace/users/albandrieu30/follow/LocalAGI
docker compose -f docker-compose.nvidia.yaml up

# Error response from daemon: could not select device driver "nvidia" with capabilities: [[gpu]]
# Fix by doing
sudo apt install nvidia-container-toolkit
sudo service docker restart

sudo nvidia-settings

# Add Antialiasingand Anisotropie

# Save settings to /workspace/users/albandrieu30/ansible-nabla/playbooks/templates/.nvidia-settings-rc.j2
sudo chown albandrieu:albandrieu /workspace/users/albandrieu30/ansible-nabla/playbooks/templates/.nvidia-settings-rc.j2
cp /home/albandrieu/.config/monitors.xml /workspace/users/albandrieu30/ansible-nabla/playbooks/templates/monitors.xml.j2

sudo lshw -c video

# Connaître la version des pilotes
glxinfo | grep OpenGL

#https://doc.ubuntu-fr.org/problemes_nvidia
apt-get install compizconfig-settings-manager

less Xorg.0.log
#[  1292.663] (--) NVIDIA(GPU-0): Samsung C49HG9x (DFP-1): 2660.0 MHz maximum pixel clock
#[  1292.663] (--) NVIDIA(GPU-0):
#[  1292.665] (--) NVIDIA(GPU-0): DFP-2: disconnected
#[  1292.665] (--) NVIDIA(GPU-0): DFP-2: Internal TMDS
#[  1292.665] (--) NVIDIA(GPU-0): DFP-2: 165.0 MHz maximum pixel clock
#
#1891.859] (WW) modeset(G0): Output DP-1-1: Strange aspect ratio (1196/336), consider adding a quirk
#[  1891.859] (WW) modeset(G0): Output DP-1-1: Strange aspect ratio (1196/336), consider adding a quirk
#[  1891.859] (WW) modeset(G0): Output DP-1-1: Strange aspect ratio (1196/336), consider adding a quirk
#[  1891.859] (WW) modeset(G0): Output DP-1-1: Strange aspect ratio (1196/336), consider adding a quirk

#profile added in /home/albandrieu/.nv/nvidia-application-profiles-rc

# See https://doc.ubuntu-fr.org/multi-ecran
find /sys/devices/ -iname edid
xrandr

xrandr -q
# DP-1 disconnected (normal left inverted right x axis y axis)
# HDMI-1 disconnected (normal left inverted right x axis y axis)
OK # HDMI-2 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 1200mm x 340mm

nvidia-xconfig
ls -lrta /etc/X11/xorg.conf

# See issue
# ucsi_ccg 0-0008: failed to reset PPM!
# https://askubuntu.com/questions/1155263/new-install-desktop-ubuntu-19-04-shows-error-message-ucsi-ccg-0-0008-failed-to
# https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1850238
sudo nano /etc/modprobe.d/blacklist-nvidia-usb.conf
#blacklist ucsi_ccg

./run-grub.sh

#Add unity
#sudo apt-get install lightdm

dpkg --list openvpn
# sudo apt remove openvpn
sudo dpkg -r openvpn
sudo dpkg --purge openvpn
sudo apt --fix-broken install
sudo apt purge openvpn*
# openvpn-dco-dkms
sudo rm -Rf /var/lib/dkms/ovpn-dco
sudo apt --fix-broken install

sudo apt install linuhttps://www.truenas.com/docs/scale/scaletutorials/dataprotection/cloudsynctasks/addgooglephotoscloudsynctask/x-headers-$(uname -r)

sudo apt install nvidia-cuda-dev nvidia-cuda-toolkit # nvidia-tesla-440-driver

# https://ajaesteves.medium.com/monitor-your-computing-system-with-prometheus-grafana-alertmanager-and-nvidia-dcgm-ea9f142d2e21
# sudo docker run --pid=host --privileged -e DCGM_EXPORTER_INTERVAL=5000 --gpus all -d -v /proc:/proc -v $PWD/default-counters.csv:/etc/dcgm-exporter/default-counters.csv -p 9400:9400 --name dcgm-exporter nvcr.io/nvidia/k8s/dcgm-exporter:3.1.7-3.1.4-ubuntu20.04
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/ /"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys A4B469963BF863C

sudo apt update && sudo apt install -y datacenter-gpu-manager

# https://docs.nvidia.com/datacenter/dcgm/latest/user-guide/getting-started.html
sudo apt install --yes datacenter-gpu-manager-4-dev

sudo systemctl enable nvidia-dcgm
sudo systemctl start nvidia-dcgm

sudo nv-hostengine
# Started host engine version 3.3.9 using port number: 5555
# https://github.com/NVIDIA/DCGM/issues/21
systemctl stop nvidia-dcgm
dcgmi discovery -l
# 1 GPU found.

# build by hand : https://github.com/NVIDIA/dcgm-exporter/tree/main#changing-metrics
# cd ~/w/jm/github/dcgm-exporter
# blabla
# https://snapcraft.io/dcgm

sudo snap install dcgm

# Start the DCGM-Exporter service (disabled by default)
sudo snap start dcgm.dcgm-exporter
# cannot create symlink in "/etc/dcgm-exporter": existing file in the way

sudo geany /usr/lib/systemd/system/nvidia-dcgm.service
# Add
# ExecStartPre=/usr/bin/dcgm-exporter

sudo dcgm-exporter &

# curl localhost:9400/metrics

sudo apt install nvidia-cuda-toolkit
nvcc --version

# npm install @ai-sdk/openai-compatible
nvidia-ctk cdi list
sudo systemctl restart nvidia-cdi-refresh.service
sudo systemctl status nvidia-cdi-refresh.path

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update

export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.1-1
  sudo apt-get install -y \
      nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}

sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
# error : docker: Error response from daemon: unknown or invalid runtime name: nvidia
# Try removing --runtime=nvidia from your command. the nvidia container runtime is an archived

# https://docs.nvidia.com/nim/large-language-models/latest/configuration.html
# docker run --rm --gpus all nvidia/cuda nvidia-smi

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/sample-workload.html
sudo docker run --rm --gpus all nvcr.io/nvidia/cuda:12.2.2-runtime-ubuntu22.04 nvidia-smi
# NVIDIA Nim Base URL

exit 0
