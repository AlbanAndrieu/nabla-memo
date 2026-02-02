#!/bin/bash
set -xv
npm install -g private-bower
ll /usr/local/bin/private-bower
ll /usr/local/lib/node_modules/private-bower
sudo private-bower
http://localhost:5678/
http://192.168.1.61:5678/packages
http://albandrieu.com:5678/packages
bower register [packageName] [gitRepo]
bower register sample-component ssh://git@github.com:AlbanAndrieu/nabla-bower-sample-component.git
bower register jquery https://github.com/jquery/jquery-dist.git
curl -X DELETE "http://albandrieu.com:5678/packages/test?access_token=password"
curl -X POST http://albandrieu.com:5678/removePackage -d '{"name":"test"}' -H "Content-Type: application/json" --header "Auth-Key:123456"
curl -X POST http://albandrieu.com:5678/refresh
ll ~/.m2/bowerRepository.json
ll ~/.m2/bowerRepositoryPublic.json
sudo apt-get install redis-server
redis-cli ping
npm install -g bower-registry
bower-registry -d redis
bower-registry -p 8089 -d redis -o '{"port": 6379, "host": "127.0.0.1"}' -P
curl http://localhost:8089/packages
curl http://albandrieu.com:8089/packages/jquery
git fetch --all --tags
https://github.com/jquery/jquery/blob/2.1.4/.bowerrc
http://localhost:8089/
npm install --save bower-registry-client
sudo find /usr/local/lib/node_modules/private-bower -type f -print0|  xargs -0 sudo sed -i 's/risk-bower/fr1cslfrqa0001/g'
cd /home/bower/private-bower
nohup node /usr/local/node/lib/node_modules/private-bower/bin/private-bower --config private-bower.json >> private-bower.log 2>&1&
lsof -i :5678
lsof -i :6789
cd /files/bower/private-bower/gitRepoCache/nabla-auth
git fetch --prune --tags
git config --local --list
git config http.sslVerify false
exit 0
