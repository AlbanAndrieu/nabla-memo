#!/bin/bash
primary_interface=$(ip route|  grep default|  awk '{print $5}'|  head -n 1)
if [ -z "$primary_interface" ];then
  echo "Primary network interface not found."
  exit 1
fi
primary_connection=$(nmcli -t -f UUID,NAME,DEVICE con show --active|  grep $primary_interface|  cut -d: -f2)
if [ -z "$primary_connection" ];then
  echo "Network connection for the primary interface not found."
  exit 1
fi
current_dns=$(nmcli con show "$primary_connection"|  grep ipv4.dns:|  awk '{print $2}')
echo "Current DNS: $current_dns"
desired_dns="1.1.1.1,1.0.0.1"
if [[ "$current_dns" == "$desired_dns" ]];then
  echo "DNS settings are already configured correctly."
  exit 0
else
  nmcli con mod "$primary_connection" ipv4.dns "$desired_dns"
  nmcli con mod "$primary_connection" ipv4.ignore-auto-dns yes
  nmcli con up "$primary_connection"
  new_dns=$(nmcli con show "$primary_connection"|  grep ipv4.dns:|  awk '{print $2}')
  echo "New DNS: $new_dns"
  if [[ "$new_dns" == "$desired_dns" ]];then
    echo "DNS settings updated successfully."
    exit 0
else
    echo "Failed to update DNS settings."
    exit 2
fi
fi
