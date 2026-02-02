#!/bin/bash
set -xv
echo
docker run docker/whalesay cowsay boo
docker ps -a -s
echo
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz containers -d|  dot -Tpng -o containers.png
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images --dot --only-labelled|  dot -Tpng -o images.png
echo
docker run -it --net host --pid host --cap-add audit_control \
  -v /var/lib:/var/lib \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /usr/lib/systemd:/usr/lib/systemd \
  -v /etc:/etc --label docker_bench_security \
  docker/docker-bench-security
echo
docker history nabla/ansible-jenkins-slave-docker:latest
echo
if [ -f check-config.sh ];then
  echo -e "check-config.sh"
else
  curl https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh > check-config.sh
fi
bash check-config.sh||  true
exit 0
