#!/bin/bash
set -xv

npm i -D wrangler@latest

cd /home/albanandrieu/w/jm/nabla-servers-symfony-sample/
npm create cloudflare -- my-app
cd my-app
# npx wrangler dev index.js
# uv tool install -e .
npx wrangler dev --assets=./public
# npx wrangler dev
cd /workspace/users/albandrieu30/nabla-site-apache/my-app
npx wrangler deploy
echo "https://https://my-app.bababou.workers.dev/"

cd /home/albanandrieu/w/nabla-site-apache
npm create cloudflare -- bababou

npx wrangler deploy
echo "https://nabla-site-bababou.bababou.workers.dev/"

cd /workspace/users/albandrieu30/nabla-site-apache/
npx wrangler deploy
echo "https://nabla-site-apache.bababou.workers.dev"

cd /workspace/users/albandrieu30/jm/fastapi-sample
npx wrangler deploy
echo "https://https://fastapi-sample.bababou.workers.dev/"

npm i mcp-remote
echo "https://playground.ai.cloudflare.com/"

exit 0
