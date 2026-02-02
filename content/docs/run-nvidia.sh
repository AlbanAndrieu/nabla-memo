#!/bin/bash
set -xv
sudo apt-get autoremove --purge nvidia-driver-*
sudo apt-get autoremove --purge nvidia-*
sudo apt-get remove nvidia-cuda-*
sudo apt-get autoremove --purge xserver-xorg-video-nouveau
ubuntu-drivers devices
apt search nvidia-driver*
sudo apt-get install nvidia-driver-460 nvidia-settings
sudo apt install nvidia-utils-470 nvidia-settings
sudo apt-get install nvidia-driver-535 nvidia-settings
sudo apt-get install nvidia-driver-535 nvidia-settings
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt remove nvidia-kernel-common-580 nvidia-firmware-580
rm  /usr/share/nvidia.nvidia-application-profiles-580.126.09-key-documentation
sudo apt --fix-broken install
sudo apt install nvidia-driver-580 nvidia-settings
lspci|  grep VGA
lspci|  grep -i nvidia
nvidia-detector
sudo apt install nvidia-utils-580
nvidia-xconfig
cd /usr/share/nvidia
sudo ln -s nvidia-application-profiles-580.126.09-key-documentation nvidia-application-profiles-key-documentation
dkms status
sudo apt install nvidia-cuda-toolkit
nvcc --version
sudo apt-get install linux-headers-$(uname -r)
cd /workspace/users/albandrieu30/follow/LocalAGI
docker compose -f docker-compose.nvidia.yaml up
sudo apt install nvidia-container-toolkit
sudo service docker restart
sudo nvidia-settings
sudo chown albandrieu:albandrieu /workspace/users/albandrieu30/ansible-nabla/playbooks/templates/.nvidia-settings-rc.j2
cp /home/albandrieu/.config/monitors.xml /workspace/users/albandrieu30/ansible-nabla/playbooks/templates/monitors.xml.j2
sudo lshw -c video
glxinfo|  grep OpenGL
apt-get install compizconfig-settings-manager
less Xorg.0.log
find /sys/devices/ -iname edid
xrandr
xrandr -q
OK
nvidia-xconfig
ls -lrta /etc/X11/xorg.conf
sudo nano /etc/modprobe.d/blacklist-nvidia-usb.conf
./run-grub.sh
dpkg --list openvpn
sudo dpkg -r openvpn
sudo dpkg --purge openvpn
sudo apt --fix-broken install
sudo apt purge openvpn*
sudo rm -Rf /var/lib/dkms/ovpn-dco
sudo apt --fix-broken install
sudo apt install linuhttps://www.truenas.com/docs/scale/scaletutorials/dataprotection/cloudsynctasks/addgooglephotoscloudsynctask/x-headers-$(uname -r)
sudo apt install nvidia-cuda-dev nvidia-cuda-toolkit
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/ /"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys A4B469963BF863C
sudo apt update&&  sudo apt install -y datacenter-gpu-manager
sudo apt install --yes datacenter-gpu-manager-4-dev
sudo systemctl enable nvidia-dcgm
sudo systemctl start nvidia-dcgm
sudo nv-hostengine
systemctl stop nvidia-dcgm
dcgmi discovery -l
sudo snap install dcgm
sudo snap start dcgm.dcgm-exporter
sudo geany /usr/lib/systemd/system/nvidia-dcgm.service
sudo dcgm-exporter&
sudo apt install nvidia-cuda-toolkit
nvcc --version
nvidia-ctk cdi list
sudo systemctl restart nvidia-cdi-refresh.service
sudo systemctl status nvidia-cdi-refresh.path
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey|  sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg&&curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list|sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g'|sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.1-1
  sudo apt-get install -y \
      nvidia-container-toolkit=$NVIDIA_CONTAINER_TOOLKIT_VERSION \
      nvidia-container-toolkit-base=$NVIDIA_CONTAINER_TOOLKIT_VERSION \
      libnvidia-container-tools=$NVIDIA_CONTAINER_TOOLKIT_VERSION \
      libnvidia-container1=$NVIDIA_CONTAINER_TOOLKIT_VERSION
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
sudo docker run --rm --gpus all nvcr.io/nvidia/cuda:12.2.2-runtime-ubuntu22.04 nvidia-smi
exit 0
