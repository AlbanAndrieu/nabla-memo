#!/bin/bash
default_config:
tts:
  - platform: google_translate
automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml
recorder:
  purge_keep_days: 30
  commit_interval: 3
  db_url: postgresql://home-assistant:barracuda-buffoon-stifle-antiquity-zoologist-annoying@postgres:5432/home-assistant?sslmode=disable
http:
  server_port: 30103
  ssl_key: /ssl/key.pem
  ssl_certificate: /ssl/cert.pem
  cors_allowed_origins:
    - https://google.com
    - https://www.home-assistant.io
    - https://albandrieu.com
    - https://home-assistant.albandrieu.com
----
wget -O - https://get.hacs.xyz|  bash -


# une clé USB300 EnOcean que j’ai appairer à chaque module Ubiwizz avec l’aide du logiciel DolphinView.

exit 0
