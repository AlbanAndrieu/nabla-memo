#!/bin/bash
sudo synaptic-pkexec
sudo dpkg-reconfigure gdm3
sudo systemctl status gdm
sudo gedit /etc/apt/apt.conf.d/00aptitude
exit 0
