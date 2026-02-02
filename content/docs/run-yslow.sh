#!/bin/bash
set -xv
npm install phantomjs -g
npm install yslow -g
npm install grunt-yslow --save-dev
grunt yslow
phantomjs yslow.js --info basic --format plain http://localhost:9090/
./node_modules/phantomjs/bin/phantomjs yslow.js --help
./node_modules/phantomjs/bin/phantomjs yslow.js -i grade -threshold "B" -f junit http://localhost:9090/ > target/surefire-reports/yslow.xml
./node_modules/phantomjs/bin/phantomjs yslow.js -i grade -threshold "B" -f tap http://localhost:9090/ > target/yslow.tap
npm install psi -g
psi http://localhost:9090/
npm install grunt-pagespeed --save-dev
grunt pagespeed
export WPT_API_KEY="A.XXX"
npm install webpagetest -g
npm install grunt-wpt --save-dev
./node_modules/webpagetest/bin/webpagetest --help
./node_modules/webpagetest/bin/webpagetest test t.co --key $WPT_API_KEY --first --location Dulles:Chrome --poll --timeout 60 --specs tco-specs.json --reporter spec
npm install -g sitespeed.io
npm install grunt-gh-pages --save-dev
npm install --global phantomas
npm install grunt-phantomas --save-dev
npm install grunt-sitespeedio --save-dev
npm install -g generator-webapp-uncss
yo webapp-uncss
npm install grunt-uncss --save-dev
sudo npm install -g phantomcss
sudo npm install -g resemble-cli
sudo npm install -g gm
npm install grunt-resemble-cli --save-dev
