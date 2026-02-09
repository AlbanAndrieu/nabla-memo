#!/bin/bash
set -xv

# — Paperless-ngx Connection —
# PAPERLESS_URL: http://webserver:8000 # Internal URL to reach Paperless-ngx
# PAPERLESS_TOKEN: “YOUR_PAPERLESS_API_TOKEN” # !!! IMPORTANT: Generate in Paperless UI (Settings → API Keys) and paste here !!!
# — AI Provider Configuration (Ollama) —
export PAPERLESS_AI_PROVIDER="ollama";
export PAPERLESS_AI_OLLAMA_HOST="http://172.17.0.24:11434"; # Internal URL to reach Ollama
# PAPERLESS_AI_OLLAMA_MODEL: llama3 # Specify default model (optional, can be set in UI)
# PAPERLESS_AI_SUMMARIZATION_MODEL: llama3 # Specify summarization model (optional)
# PAPERLESS_AI_CHAT_MODEL: llama3 # Specify chat model (optional)
# — Other Optional Settings —
# PAPERLESS_AI_DEFAULT_LANGUAGE: eng
# PAPERLESS_AI_MODE: auto # or ‘manual’
# PAPERLESS_AI_PROMPT: “Analyze this document…”
# PAPERLESS_AI_MAX_TOKENS: 1000

exit 0
