#!/bin/bash
#set -xv

#https://medium.com/@SDWouters/protect-your-bitcoin-through-privacy-2f6406bfc61d
#https://8bitcoin.medium.com/how-to-run-a-bitcoin-full-node-over-tor-on-an-ubuntu-linux-virtual-machine-bdd7e9415a70

sudo add-apt-repository universe
sudo apt install build-essential autoconf libtool pkg-config libboost-all-dev libssl-dev libevent-dev doxygen libzmq3-dev libdb++-dev libsqlite3-dev
sudo apt-get install libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev

sudo add-apt-repository ppa:bitcoin/bitcoin
grep bitcoin /etc/apt/sources.list.d/*
sudo geany /etc/apt/sources.list.d/bitcoin-ubuntu-bitcoin-jammy.list
# use bionic
sudo apt-get update
#sudo apt-get install libdb4.8-dev libdb4.8++-dev
sudo apt-get install libdb-dev libdb++-dev
#sudo apt-get install libbase58-dev

ll /home/albandrieu/w/follow/bitcoin/doc/build-unix.md

cd /home/albandrieu/w/follow/bitcoin
git remote -v

git remote add upstream https://github.com/bitcoin/bitcoin/
git fetch --tags upstream
git checkout tags/v25.0

export BDB_PREFIX="/workspace/users/albandrieu30/follow/bitcoin/depends/x86_64-pc-linux-gnu"

./autogen.sh
make -C depends NO_BOOST=1 NO_LIBEVENT=1 NO_QT=1 NO_SQLITE=1 NO_NATPMP=1 NO_UPNP=1 NO_ZMQ=1 NO_USDT=1

# ./configure     BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8"     BDB_CFLAGS="-I${BDB_PREFIX}/include"
./configure CXX=clang++ CC=clang --disable-tests --enable-hardening --enable-c++20 --with-incompatible-bdb

make -j 16
make install # optional

#https://bitcoin.org/en/full-node#other-linux-gui

#https://specifications.freedesktop.org/autostart-spec/autostart-spec-latest.html#startup

ll ~/.config/autostart/bitcoin*

cd /var/lib
ln -s /media/bitcoin/.bitcoin/ bitcoind

# Service bitcoind disabled, using bitcoin-qt as start application
##mkdir /run/bitcoind
#sudo geany /usr/lib/systemd/system/bitcoind.service
#
#sudo systemctl daemon-reload
#sudo systemctl start bitcoind
#sudo systemctl status bitcoind
#
##bitcoind -daemon
#/usr/local/bin/bitcoind -daemon \
#	-debug=tor \
#	-conf=/etc/bitcoin/bitcoin.conf \
#	-datadir=/media/bitcoin/.bitcoin/
##	-pid=/run/bitcoind/bitcoind.pid \

#sudo apt-get -f install libboost-all-dev
#sudo apt-get -f install libboost-system-dev

#/usr/local/bin/bitcoin-qt -listenonion -prune=0 -txindex=1
/usr/local/bin/bitcoin-qt -disablewallet -listenonion -listen=1 -prune=0 # -debug=tor -proxy=127.0.0.1:9051
# -wallet=/media/bitcoin/.bitcoin/wallets/albandrieu-test-10-04-2021/
#/usr/local/bin/bitcoin-qt -server -min -chain=main -listenonion
#/usr/local/bin/bitcoin-qt -min -chain=main -debug=tor
grep "tor: Successfully connected" /media/bitcoin/.bitcoin/debug.log

#crontab -e
#@reboot bitcoind -daemon

# https://bitnodes.io/nodes/92.151.120.191-8333/?activated=1

watch bitcoin-cli getnetworkinfo
bitcoin-cli getconnectioncount
bitcoin-cli getpeerinfo
bitcoin-cli getpeerinfo | grep true
#bitcoin-cli -rpcport=8333 -getinfo -rpcconnect=92.151.120.191
#You can also quickly see a list of onion nodes you are connected to by running:
bitcoin-cli getpeerinfo | grep addr

cd ~
#mkdir .bitcoin
touch .bitcoin/bitcoin.conf
echo "txindex=1" >>.bitcoin/bitcoin.conf
echo "onlynet=onion" >>.bitcoin/bitcoin.conf
echo "maxconnections=20" >>.bitcoin/bitcoin.conf

ll /etc/bitcoin/bitcoin.conf
ll /media/bitcoin/.bitcoin/bitcoin.conf
geany /lib/systemd/system/bitcoind.service

# Change
# ExecStart=/usr/local/bin/bitcoind -daemon -disablewallet -listenonion \
#     -debug=tor \
#     -pid=/run/bitcoind/bitcoind.pid \
#     -datadir=/media/bitcoin/.bitcoin/

sudo systemctl daemon-reload
sudo systemctl start bitcoind.service

./run-tor.sh
#geany /etc/tor/torrc
#geany /usr/share/tor/tor-service-defaults-torrc
sudo systemctl restart tor
journalctl -f | grep tor -i

#tail -f ~/.bitcoin/debug.log
tail -f /media/bitcoin/.bitcoin/debug.log
#Config file arg: onlynet="onion

firefox bitnodes.earn.com
bitcoin-cli getnetworkinfo | grep address
# in75ux54bxxk6bih7qbh7kqrjkmjokauccdmlfyasti2k7ny6vv5xiad.onion

# https://kycnot.me/
# local.bitcoin.com

exit 0
