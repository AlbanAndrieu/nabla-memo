#!/bin/bash
sudo dpkg -i NessusAgent-10.6.4-ubuntu1404_amd64.deb
sudo /opt/nessus_agent/sbin/nessuscli agent link --name=XX_workstation --key=XXX --cloud
/bin/systemctl start nessusagent.service
exit 0
