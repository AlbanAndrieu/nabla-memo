#!/bin/bash
set -xv
sudo apt-get install gcc cpp g++ automake1.9 autoconf libtool flex bison python-software-properties
sudo apt-get --purge remove node
ll /usr/sbin/node
/bin/ls: cannot access /usr/sbin/node: No such file or directory
sudo apt-get install nodejs
curl -L https://www.npmjs.com/install.sh|  sh
sudo apt-get install karma-tools
npm config ls -l|  grep config
npm config set prefix /usr/local
npm config get prefix
export NODE_PATH=/usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript:/usr/local/lib/node_modules
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
cd /usr/local/src
wget http://nodejs.org/dist/node-latest.tar.gz
tar zxvf node-latest.tar.gz
cd node-v0.1*
./configure
make
sudo make install
echo $NODE_PATH
/usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript
which node
/usr/bin/node
node --version
v0.10.37
which nodejs
/usr/bin/nodejs
nodejs --version
v0.10.37
npm --version
2.13.0
npm install -g grunt@1.5.3
npm install -g grunt-cli@1.4.3
npm install -g bower@1.8.13
npm install -g selenium-webdriver
npm install -g grunt-contrib-compress
npm install -g node-gyp
npm install -g grunt-pagespeed-junit@0.3.1
npm install -g grunt-yslow-test@0.1.0
npm install nsp --global
npm install -g angular@1.3.15
npm install -g casperjs@1.1.4
npm install -g coffee-script@1.10.0
npm install -g connect@1.9.2
npm install -g eslint@6.8.0
npm install -g jshint@2.9.5
npm install -g jsonlint@1.6.2
npm install -g json2csv@4.3.3
npm install -g nsp@3.2.1
npm install -g phantomjs-prebuilt@2.1.16
npm install -g phantomas@1.20.1
npm install -g prettier@2.0.4
npm install -g slimerjs@0.10.3
npm install -g tap-eater@0.0.3
npm install -g webdriver-manager@12.1.7
npm install -g yarn@1.22.19
npm install -g shrinkwrap@0.4.0
npm install -g newman@4.5.5
npm install -g xunit-viewer@5.1.11
npm install -g dockerfile_lint@0.3.3
npm install -g grunt-retire@1.0.8
npm install -g bower-nexus3-resolver@1.0.4
npm install -g npm-groovy-lint@8.2.0
npm install -g mega-linter-runner
npm install -g jscpd@3.4.2
npm install -g less
npm install -g jest@28.1.0
npm install -g markdownlint
npm install -g secretlint@9.3.1
npm install -g @secretlint/secretlint-rule-preset-recommend
secretlint .
npm install -g v8r
npm install -g doctor
npm install -g yo
npm install -g connect-livereload
npm install -g gm
npm install -g tldr
npm install -g sql-lint
npm install -g pyright
npm install -g pyright-to-gitlab-ci
npm install grunt
npm install grunt-cli
cd /usr/local/bin/
ln -s /usr/local/lib/node_modules/karma/bin/karma /usr/local/bin/karma
sudo chmod -R 777 /usr/local/lib/node_modules/
karma --version
Karma version: 0.10.9
karma start karma-ri-header.conf.js
grunt karma:riHeader​
grunt --version
grunt-cli v0.1.13
bower --version
1.2.8
webdriver-manager update
npm -g ls
npm config set registry https://registry.bower.io
npm config ls -l|  grep registry
npm install -g grunt bower yo generator-karma generator-angular
yo
npm install --save grunt-google-cdn
sudo apt-get remove node
sudo apt-get remove --purge node
sudo apt-get autoremove
npm install
npm start : start a local development web-server
npm test : start the Karma unit test runner
npm run protractor : run the Protractor end 2 end tests
npm run update-webdriver : install the drivers needed by Protractor
npm install -g private-bower
ll /usr/local/bin/private-bower
ll /usr/local/lib/node_modules/private-bower
sudo private-bower
http://localhost:5678/
http://localhost:5678/packages
bower register [packageName] [gitRepo]
bower register sample-component ssh://git@stash:7999/risk/nabla-sample-component.git
sudo apt-get install redis-server
redis-cli ping
npm install -g bower-registry
bower-registry -d redis
bower-registry -p 8089 -d redis -o '{"port": 6379, "host": "127.0.0.1"}' -P
curl http://localhost:8089/packages
curl http://localhost:8089/packages/jquery
http://localhost:8089/
npm install --save bower-registry-client
bower cache list
bower cache clean
bower ls angular
npm install
grunt build
grunt karma:unit
grunt documentation
grunt protractor:e2e
curl -X DELETE "http://localhost:5678/packages/test?access_token=password"
curl -X POST http://localhost:5678/removePackage -d '{"name":"test"}' -H "Content-Type: application/json" --header "Auth-Key:123456"
ll ~/.m2/bowerRepository.json
ll ~/.m2/bowerRepositoryPublic.json
npm install karma-jasmine@2_0 --save-dev
npm install jasmine-core --save-dev
npm install --save-dev jasmine-reporters@^2.0.0
npm install grunt-postcss pixrem autoprefixer-core cssnano --save-dev
cd /var/www/html/download
cd nodejs/v0.12.4
npm view npm dist-tags
sudo npm install npm@latest -g
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo apt-get install rubygems
sudo gem install sass
sudo gem install compass
sudo apt-get install coffeescript
coffee --version
sudo apt-get install google-chrome-stable
sudo apt-get install chromium-browser
sudo webdriver-manager update
sudo /usr/local/lib/node_modules/protractor/selenium/chromedriver --version
ll /usr/local/lib/node_modules/protractor/selenium/selenium-server-standalone-2.45.0.jar
/usr/bin/google-chrome --version
/usr/bin/chromium-browser --version
sudo su - root
npm install -g devtools-terminal
devtools-terminal --install --id=leakmhneaibbdapdoienlkifomjceknl
npm outdated
npm update
npm login --registry=https://albandrieu.com/nexus/repository/npm_internal/
npm init vue@2
npx v8r@latest .mega-linter.yml
npx storybook init
npm update
export NODE_ENV=production
exit 0
