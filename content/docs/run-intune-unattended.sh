#!/bin/bash
if ! dpkg -l|  grep -qw unattended-upgrades;then
  apt-get update&&  apt-get install -y unattended-upgrades
  if [ $? -ne 0 ];then
    echo "Failed to install unattended-upgrades."
    exit 1
fi
fi
if ! grep -Rq "^Unattended-Upgrade::Allowed-Origins.*\"$distro_id:$distro_codename-security\";"     /etc/apt/apt.conf.d/50unattended-upgrades;then
  echo 'Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}-security";
//  Add more origins/repositories here, if necessary
};' >> /etc/apt/apt.conf.d/50unattended-upgrades
  if [ $? -ne 0 ];then
    echo "Failed to configure unattended-upgrades for automatic security updates."
    exit 2
fi
fi
systemctl enable unattended-upgrades
if [ $? -ne 0 ];then
  echo "Failed to enable unattended-upgrades service."
  exit 3
fi
systemctl start unattended-upgrades
if [ $? -ne 0 ];then
  echo "Failed to start unattended-upgrades service."
  exit 4
fi
echo "Unattended-upgrades configured successfully."
exit 0
