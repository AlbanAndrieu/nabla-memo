#!/bin/bash
set -xv

# https://github.com/ankane/pghero

sudo pghero config:set DATABASE_URL=postgres://<USER>:<PASSWORD>@<HOSTNAME>:5432/<NAME_OF_YOUR_DB>
sudo pghero config:set PORT=3001
sudo pghero config:set RAILS_LOG_TO_STDOUT=disabled
sudo pghero scale web=1

exit 0
