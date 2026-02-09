#!/bin/bash
#set -xv

# https://portal.intruder.io/onboarding

sudo dpkg -i NessusAgent-10.6.4-ubuntu1404_amd64.deb
sudo /opt/nessus_agent/sbin/nessuscli agent link --name=cXXX --key=XXX --cloud

/bin/systemctl start nessusagent.service
# To link this agent, use the '/opt/nessus_agent/sbin/nessuscli agent' command.
# Type '/opt/nessus_agent/sbin/nessuscli agent help' for more info.

# 203.12.218.0/24, 18.194.95.64/26, 3.124.123.128/25, 3.67.7.128/25, 54.93.254.128/26

exit 0
