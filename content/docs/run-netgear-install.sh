#!/bin/bash
set -xv

# See https://www.netgear.com/support/product/r7000.aspx#ConfigurationAssistance_CommonTopics

https://www.expressvpn.com/fr/support/vpn-setup/app-for-routers-netgear/
https://www.expressvpn.com/router-setup/download-firmware

Version actuelle du micrologiciel (firmware)	V1.0.11.126_10.2.112
Version chargée	V1.0.9.88_10.2.88

MAC: FOAD4E232F99
SN : NTG2210000222
NDI : ca965920646bb527e4490

#See expressvpnrouter.com
#See http://192.168.0.1/
http://192.168.132.1/ui/get-started

https://www.expressvpn.com/fr/vpnmentor1

82.66.4.247

ROUTER IP : 192.168.132.1
DHCP : 192.168.132.10

# ERROR log
[WLAN access rejected: incorrect security] from MAC 50:EC:50:05:3F:4F, Monday, Sep 02,2024 15:08:20
# Mean that a hardware is trying to connect to wifi but cannot (issue with credential!)

# Use network  NETGEAR 75 5G seems better (2.4 Ghz) than NETGEAR 75
# Disable IP v6
# Disable Make available to other users
# IPV4 -> DNS 1.1.1.1, 1.0.0.1
# Disable : IPV4 Use this connection only for resources in its network
# NETGEAR75-5G -> Channel 100 -> 104 -> 56
# Enable Smart Connect -> NOK (unstable!)

# https://medium.com/@redfanatic7/protect-your-wifi-from-hackers-a7e6479fbedc
# Security:
# Go to Advanced
# Enable SSID Broadcast -> Disable
# WPS will be disabled https://fr.wikipedia.org/wiki/Wi-Fi_Protected_Setup
# Advance Setup -> Wireless Settings
# WPS Settings -> Enable Router-s PIN -> Disable
# Check WPS is disabled
sudo apt install reaver
sudo wash -i wlp0s20f3

# Go to Security -> Access Control
# Block all new devices from connecting

# sFlow / jFlow
# https://kb.netgear.com/21917/What-is-sFlow-and-how-does-it-work-with-my-managed-switch

exit 0
