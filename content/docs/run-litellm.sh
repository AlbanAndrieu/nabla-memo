#!/bin/bash
set -xv

# https://gdsks.medium.com/how-to-use-openclaw-with-azure-openai-using-litellm-proxy-7b7d05cddf13

cd ~

# Create virtual environment
python3 -m venv ~/litellm-venv
source ~/litellm-venv/bin/activate

pip install 'litellm[proxy]'
# pip install prisma
export DATABASE_URL="postgresql://nabla:yUuzxe5s2Tsb@172.17.0.24:5432/postgres"
echo $DATABASE_URL

npm install prisma --save-dev

npm install @prisma/client

geany ~/litellm_config.yaml

litellm --config ~/litellm_config.yaml --port 4100

# python -m prisma_cleanup

# issue : https://github.com/BerriAI/litellm/issues/16172
ll  ~/litellm-venv/lib/python3.12/site-packages/litellm/proxy/schema.prisma
prisma generate --schema ~/litellm-venv/lib/python3.12/site-packages/litellm/proxy/schema.prisma
# npx prisma migrate

echo http://0.0.0.0:4100/

curl http://localhost:4100/v1/chat/completions   -H "Authorization: Bearer ${LITELLM_MASTER_KEY}"   -H "Content-Type: application/json"   -d '{
    "model": "gpt1",
    "messages": [{"role": "user", "content": "Say hello!"}]
  }'

# OK gpt1 gpt2

exit 0
