#!/bin/bash
set -xv

sudo snap remove go
#sudo snap install go --classic

# See https://github.com/golang/dep#installation
#sudo apt-get install go-dep
sudo apt remove --autoremove golang
# sudo apt install golang # golang-1.24

# https://dev.to/shihanng/managing-go-versions-with-direnv-19mb
# https://github.com/moovweb/gvm
sudo apt-get install bison
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.22.4
gvm use go1.22.4 --default
gvm list

ll /usr/lib/go-1.22/bin/go
ll /usr/lib/go/bin/go

# Below is using workstation GO
export GOROOT=/usr/lib/go # link to /usr/lib/go-1.18
# Below is using direnv GO
export GOROOT=/workspace/users/albandrieu30/jm/conflict-checker/.direnv/bin/go
export GOPATH=$HOME/go
if [ -f "${GOROOT}/bin/go" ]; then
  PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"
fi

#wget -P /tmp https://go.dev/dl/go1.18.1.linux-amd64.tar.gz
#tar -C /tmp -xzf /tmp/go1.18.1.linux-amd64.tar.gz
#sudo cp -r /tmp/go /usr/bin/go

which go
go version
go env

go env GOROOT
go build

gdb ./hello

go run ./cmd

#sudo /usr/bin/go/bin/go install github.com/hashicorp/levant@main

curl -L https://github.com/hashicorp/levant/releases/download/0.2.9/linux-amd64-levant -o levant
sudo mv levant /usr/bin/go/bin/
sudo chmod +x /usr/bin/go/bin/levant

# as root
# export GO111MODULE=on
go install github.com/cweill/gotests/gotests@latest # visual studio
go install mvdan.cc/sh/v3/cmd/shfmt@latest          # shfmt
# go get -v github.com/mvdan/sh@v3.5.1
go install mvdan.cc/sh/v3/cmd/gosh@latest
go install github.com/aquasecurity/tfsec/cmd/tfsec@latest
#go get -v github.com/aquasecurity/tfsec/cmd/tfsec@latest
go install github.com/minamijoyo/tfupdate@latest
#go install -v golang.org/x/tools/gopls@latest
#go install -v github.com/go-delve/delve/cmd/dlv@latest
#go install github.com/controlplaneio/kubesec/v2@latest # https://github.com/controlplaneio/kubesec
go install github.com/BurntSushi/toml/cmd/tomlv@latest
go get golint@none
go install golang.org/x/lint/golint@latest
go install github.com/editorconfig-checker/editorconfig-checker/v3/cmd/editorconfig-checker@latest
editorconfig-checker package.json

#curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.20.0
sudo snap install gosec
gosec ./...
gosec -exclude-dir '.direnv' -conf ~/config.json -exclude=G104 ./...
# gosec -tests ./...

go clean -cache -modcache

# See https://princepereira.medium.com/install-grpccurl-in-ubuntu-6ad71fd3ed31
# go get github.com/fullstorydev/grpcurl/...
# go install github.com/fullstorydev/grpcurl/cmd/grpcurl
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

go run cmd/middleware.go cmd/assistant.go

# Check dependency
go mod why -m golang.org/x/crypto

exit 0
