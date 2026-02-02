#!/bin/bash
set -xv
docker pull owasp/dependency-track
docker volume create --name dependency-track
docker run -d -m 8192m -p 8087:8080 --name dependency-track -v dependency-track:/data owasp/dependency-track
exit 0
