#!/bin/bash
sudo docker swarm init --advertise-addr 172.17.0.57
docker swarm join --token XXX 172.17.0.57:2377
curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
docker stack deploy --compose-file=portainer-agent-stack.yml portainer
exit 0
