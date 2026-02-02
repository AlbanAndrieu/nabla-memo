#!/bin/bash
set -xv
sudo nano /etc/apt/sources.list
deb http://download.virtualbox.org/virtualbox/debian precise contrib
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O-|  sudo apt-key add -
sudo apt-get update
sudo apt-get install dkms
sudo apt-get install virtualbox=6.1.4-dfsg-2
sudo mkdir -p /workspace/virtualbox/$USER/.VirtualBox
sudo chown -R albandri:albandri /workspace/virtualbox/$USER
cp -R ~/.VirtualBox /workspace/virtualbox/$USER
rm -rf ~/.VirtualBox
ln -s /workspace/virtualbox/$USER/.VirtualBox ~/.VirtualBox
cp -r ~/VirtualBox\ VMs /workspace/virtualbox/$USER
mkdir -p /workspace/virtualbox/$USER/VirtualBox\ VMs
ln -s /workspace/virtualbox/$USER/VirtualBox\ VMs ~/VirtualBox\ VMs
sudo mkdir -p /local/virtualbox/Windows7/Shared
cd ~/.VirtualBox
sudo apt-get install virtualbox-ext-pack
sudo apt-get install virtualbox-guest-dkms
wget http://download.virtualbox.org/virtualbox/5.0.16/Oracle_VM_VirtualBox_Extension_Pack-5.0.16-105871.vbox-extpack
sudo VBoxManage list extpacks
sudo VBoxManage extpack uninstall 'Oracle VM VirtualBox Extension Pack'
sudo VBoxManage extpack cleanup
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.0.16-105871.vbox-extpack
vboxmanage internalcommands converttoraw OpenSolaris.vdi OpenSolaris.raw
sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager
sudo adduser albandri libvirtd
sudo virsh -c qemu:///system list
qemu-img convert -O vmdk OpenSolaris.raw OpenSolaris.vmdk
VBoxManage list vms
VBoxManage controlvm vagrant-windows-2012 poweroff
VBoxManage unregistervm vagrant-windows-2012 --delete
VBoxManage modifyvm "vagrant-windows-2012" --natpf1 delete "winrm"
VBoxManage modifyvm "vagrant-windows-2012" --memory 4096
VBoxManage modifyvm "vagrant-windows-2012" --natpf1 "tcp-port3306,tcp,,3306,,3306"
VBoxManage modifyvm "vagrant-windows-2012" --natpf1 "udp-port3306,udp,,3306,,3306"
VBoxManage metrics list "vagrant-windows-2012"
VBoxManage debugvm "vagrant-windows-2012" osinfo
VBoxManage startvm "vagrant-windows-2012" --type headless
VBoxManage snapshot vagrant-windows-2012 take snap-12092016-1 -desc "stable"
VBoxManage snapshot vagrant-windows-2012 list
yum install binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
yum install VirtualBox-4.3
vboxmanage list usbhost
sudo apt-get install gnome-system-tools
sudo usermod -aG vboxusers albandri
groups
sudo service vboxdrv restart
sudo apt-get install linux-image-extra-4.8.0-34-generic linux-image-extra-virtual
sudo dpkg -i *.deb
sudo apt-get install mokutil
sudo mokutil --disable-validation
sudo modprobe vboxdrv
sudo apt-get --reinstall install virtualbox-dkms
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Descriptive name/"
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vboxdrv)
sudo mokutil --import MOK.der
sudo apt install virtualbox-qt
sudo service virtualbox status
VBoxManage --version
sudo apt-get install hwinfo
sudo hwinfo --framebuffer|  grep 1280x1024
sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="video=0x0345"
GRUB_GFXMODE=1280x1024x24
GRUB_GFXPAYLOAD_LINUX=1280x1024x24
sudo update-grub
sudo reboot
systemctl status vboxweb.service
service --status-all|  grep vbox
exit 0
