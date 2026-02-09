#!/bin/bash
set -xv

# See https://www.boundaryproject.io/

# See https://www.strongdm.com/

# https://github.com/ovh/the-bastion

bastion --osh info

groupList --all
groupListServers --group admins
groupListServers --group devs_fobo

groupInfo --group admins
from="10.11.0.15,149.202.182.175" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfu+tUYYdry1ZqqQZNyvlHWoz93v7pdPn2IoIFzBoVl admins@gra1bastion:1614786269

# you must be a group aclkeeper to use this command
ssh bastionadm@gra1bastion
groupAddServer --group admins --host 10.30.0.39 --port 22 --user aandrieu

# https://github.com/ovh/the-bastion-ansible-wrapper
# Using Ansible SSH Connection through The Bastion

exit 0
