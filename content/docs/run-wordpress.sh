#!/bin/bash
set -xv
sudo nano /etc/apache2/mods-available/pagespeed.conf
ModPagespeed unplugged
sudo service apache2 restart
