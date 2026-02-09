#!/bin/bash

# Identify the primary network interface based on the default route
primary_interface=$(ip route | grep default | awk '{print $5}' | head -n 1)

# Check if the primary interface was found
if [ -z "$primary_interface" ]; then
  echo "Primary network interface not found."
  exit 1 # Exit code 1 indicates that the primary network interface was not found
fi

# Get the connection name associated with the primary interface
primary_connection=$(nmcli -t -f UUID,NAME,DEVICE con show --active | grep $primary_interface | cut -d: -f2)

# Check if the primary connection was found
if [ -z "$primary_connection" ]; then
  echo "Network connection for the primary interface not found."
  exit 1 # Exit code 1 indicates that the network connection was not found
fi

# Retrieve current DNS settings
current_dns=$(nmcli con show "$primary_connection" | grep ipv4.dns: | awk '{print $2}')
echo "Current DNS: $current_dns"

# Desired DNS settings as a single string to match nmcli output format
desired_dns="1.1.1.1,1.0.0.1"

# Check if DNS settings are already configured correctly
if [[ "$current_dns" == "$desired_dns" ]]; then
  echo "DNS settings are already configured correctly."
  exit 0 # Exit code 0 indicates success
else
  # Update DNS settings
  nmcli con mod "$primary_connection" ipv4.dns "$desired_dns"
  nmcli con mod "$primary_connection" ipv4.ignore-auto-dns yes
  nmcli con up "$primary_connection"

  # Verify changes
  new_dns=$(nmcli con show "$primary_connection" | grep ipv4.dns: | awk '{print $2}')
  echo "New DNS: $new_dns"
  if [[ "$new_dns" == "$desired_dns" ]]; then
    echo "DNS settings updated successfully."
    exit 0 # Exit code 0 indicates success
  else
    echo "Failed to update DNS settings."
    exit 2 # Exit code 2 indicates failure to update DNS settings
  fi
fi
