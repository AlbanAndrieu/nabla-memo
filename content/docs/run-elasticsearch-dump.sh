set -xv

# https://www.npmjs.com/package/elasticdump
npm i elasticdump

./node_modules/.bin/elasticdump \
  --input=http://gradbsev2integr01:9200/nablase \
  --output=$ |
  gzip >/var/www/es/v2-elasticsearch/nablase-2025-05-16.json.gz

exit 0
