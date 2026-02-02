#!/bin/bash
set -xv
npm install -g localtunnel
npx localtunnel --port 8000
exit 0
