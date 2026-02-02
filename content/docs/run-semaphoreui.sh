#!/bin/bash
set -xv
sudo snap install semaphore
echo "http://localhost:3000"
sudo semaphore user list
sudo semaphore user add --admin --login aandrieu --name aandrieu --email aandrieu@jusmundi.com --password $SEMAPHORE_PASSWORD
sudo semaphore user add --admin \
  --login admin \
  --password changeme \
  --name "Admin" \
  --email "admin@localhost" \
  --no-config
semaphore server --no-config
exit 0
