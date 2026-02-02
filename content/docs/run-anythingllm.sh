#!/bin/bash
set -xv

./home/albandrieu/AnythingLLMDesktop.AppImage

# http://docs.anythingllm.com/installation-desktop/linux#install-using-the-installer-script
See other ways of importing Prisma Client: http://pris.ly/d/importing-client

[OllamaProcessManager] Ollama will bind on port 35825 35431 when booted.
[OllamaProcessManager] Creating Ollama models folder in application storage. {
  destination: '/home/albandrieu/.config/anythingllm-desktop/storage/models/ollama'
}

Ollama will bind on port 37111 when booted

echo "http://localhost:35825/"
echo "http://localhost:35431/"

ll /home/albandrieu/.config/anythingllm-desktop/config.json

cd /home/albandrieu/.config/anythingllm-desktop/storage
ll anythingllm.db
geany /home/albandrieu/.config/anythingllm-desktop/storage/plugins/anythingllm_mcp_servers.json

# https://docs.anythingllm.com/browser-extension/install

# http://localhost:3001/api
# http://127.0.0.1:8888/

cd ~/.config/anythingllm-desktop/storage
ln -s /media/model models

# Add n8n
# allm-community-id:agent-skill:SZxzBiZ4B3XkgVLs3yF1

exit 0
