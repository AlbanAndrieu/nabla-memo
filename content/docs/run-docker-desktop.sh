#!/bin/bash
set -xv

#https://blog.docker.com/2013/07/docker-desktop-your-desktop-over-ssh-running-inside-of-a-docker-container/

#https://docs.docker.com/desktop/linux/install/
#sudo apt remove docker-desktop
#rm -r $HOME/.docker/desktop
#sudo rm /usr/local/bin/com.docker.cli
#sudo apt purge docker-desktop

# install docker-desktop on ubuntu
# from https://docs.docker.com/desktop/linux/release-notes/

# ubuntu 24
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
sudo apt install gnome-terminal

wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.34.2-amd64.deb?utm_source=docker &
utm_medium=webreferral &
utm_campaign=docs-driven-download-linux-amd64
sudo apt-get install ./docker-desktop- <version >- <arch >.deb

docker context use desktop-linux

sudo systemctl stop docker docker.socket containerd
sudo systemctl disable docker docker.socket containerd

sudo systemctl --user start docker-desktop
sudo systemctl --user enable docker-desktop

sudo apt remove docker-desktop
rm -Rf ~/.docker/desktop

# issue starting
# remove s from
# 	"credStore": "desktop",
geany ~/.docker/config.json
#{
#	"auths": {
#		"378612673110.dkr.ecr.eu-central-1.amazonaws.com": {
#			"auth": "XXX"
#		},
#		"783876277037.dkr.ecr.eu-west-3.amazonaws.com": {
#			"auth": "XXX"
#		},
#		"https://index.docker.io/v1/": {
#			"auth": "XXX"
#		},
#		"registry.gitlab.com": {
#			"auth": "XXX"
#		}
#	},
#	"credsStore": "desktop",
#	"plugins": {
#		"debug": {
#			"hooks": "exec"
#		},
#		"scout": {
#			"hooks": "pull,buildx build"
#		}
#	},
#	"features": {
#		"hooks": "true"
#	}
#}

key=$(gpg --no-auto-check-trustdb --list-secret-keys --with-colon | grep ^sec | cut -d: -f5)
# WARNING 2 keys
echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key "$key" trust
# or
# (echo trust &echo 5 &echo y &echo quit &echo save) | gpg  --batch --command-fd 0 --edit-key "$key"
# or
# printf "5\ny\n" | gpg --command-fd 0 --expert --edit-key "$key" trust

pass show docker-credential-helpers | sed -e 's/(.)/*/g'

# daemon at unix:///home/albanandrieu/.docker/desktop/docker.sock. Is the docker daemon running

docker context show
docker context ls
# sudo ln -s /home/albanandrieu/.docker/desktop/docker.sock /var/run/docker.sock
docker context use default

exit 0
