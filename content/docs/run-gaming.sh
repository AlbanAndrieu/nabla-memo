#!/bin/bash
sudo nano /etc/systemd/system.conf
DefaultLimitNOFILE=1024:524288
sudo nano /etc/systemd/user.conf
DefaultLimitNOFILE=524288
ulimit -Hn
exit 0
