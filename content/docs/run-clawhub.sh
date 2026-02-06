#!/bin/bash

./run-ai.sh

npm install -g openclaw@latest
geany ~/.openclaw/openclaw.json
geany ~/.openclaw/.env

openclaw --version

openclaw dashboard

npm i -g clawhub

clawhub search "calendar"
clawhub install caldav-calendar
ll /home/albandrieu/.openclaw/workspace/skills/caldav-calendar

sudo apt install vdirsyncer
mkdir -p /home/albandrieu/.config/vdirsyncer/config
vdirsyncer sync

clawhub install humanize-ai-text
ll /home/albandrieu/.openclaw/workspace/skills/humanize-ai-text

clawhub install wacli
ll /home/albandrieu/.openclaw/workspace/skills/wacli

openclaw onboard --install-daemon
openclaw channels login
openclaw gateway --port 18789

ll /etc/systemd/system/openclaw.service
ll /etc/systemd/system/litellm.service

sudo systemctl daemon-reload
sudo systemctl enable litellm openclaw
sudo systemctl start litellm openclaw

sudo journalctl -u litellm -f

openclaw hooks list
openclaw hooks enable session-memory
openclaw hooks info session-memory
openclaw hooks check

openclaw hooks update --all

openclaw hooks enable command-logger
# Recent commands
tail -n 20 ~/.openclaw/logs/commands.log

# Pretty-print
cat ~/.openclaw/logs/commands.log | jq .

# Filter by action
grep '"action":"new"' ~/.openclaw/logs/commands.log | jq .

openclaw hooks enable boot-md

# NOK openclaw hooks install soul-evil
openclaw doctor --fix
openclaw hooks enable soul-evil

exit 0
