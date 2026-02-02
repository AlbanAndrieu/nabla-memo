#!/bin/bash
set -xv
/usr/local/bin/molecule --version
python3 -m pip install --user ansible "ara[server]"
export ANSIBLE_CALLBACK_PLUGINS="$(python3 -m ara.setup.callback_plugins)"
python3 -m ara.setup.path
python3 -m ara.setup.action_plugins
python3 -m ara.setup.callback_plugins
python3 -m ara.setup.ansible|  tee ansible.cfg
molecule check
exit 0
