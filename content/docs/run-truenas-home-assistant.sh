#!/bin/bash
#set -xv

# Do not set certificate when creating

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
  # use_x_forwarded_for: true
  # trusted_proxies:
  #   - 10.0.0.200
  #   - 82.66.4.247
  #   - 10.20.0.0/24
  #   - 172.17.0.33/24
  # ip_ban_enabled: true
  # login_attempts_threshold: 5
----


# Add HACS
# https://www.domo-blog.fr/comment-installer-hacs-home-assistant-store-integrations-custom-ha/
wget -O - https://get.hacs.xyz|  bash -

# une clé USB300 EnOcean que j’ai appairer à chaque module Ubiwizz avec l’aide du logiciel DolphinView.

# TODO Add Total Energy : Clef console live / Key atom
# Add Withings

# https://www.mi.com/fr/product/mijia-smart-air-purifier-6/

exit 0
