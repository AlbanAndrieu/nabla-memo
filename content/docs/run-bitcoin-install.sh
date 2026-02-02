#!/bin/bash
sudo add-apt-repository universe
sudo apt install build-essential autoconf libtool pkg-config libboost-all-dev libssl-dev libevent-dev doxygen libzmq3-dev libdb++-dev libsqlite3-dev
sudo apt-get install libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev
sudo add-apt-repository ppa:bitcoin/bitcoin
grep bitcoin /etc/apt/sources.list.d/*
sudo geany /etc/apt/sources.list.d/bitcoin-ubuntu-bitcoin-jammy.list
sudo apt-get update
sudo apt-get install libdb-dev libdb++-dev
ll /home/albandrieu/w/follow/bitcoin/doc/build-unix.md
cd /home/albandrieu/w/follow/bitcoin
git remote -v
git remote add upstream https://github.com/bitcoin/bitcoin/
git fetch --tags upstream
git checkout tags/v25.0
export BDB_PREFIX="/workspace/users/albandrieu30/follow/bitcoin/depends/x86_64-pc-linux-gnu"
./autogen.sh
make -C depends NO_BOOST=1 NO_LIBEVENT=1 NO_QT=1 NO_SQLITE=1 NO_NATPMP=1 NO_UPNP=1 NO_ZMQ=1 NO_USDT=1
./configure CXX=clang++ CC=clang --disable-tests --enable-hardening --enable-c++20 --with-incompatible-bdb
make -j 16
make install
ll ~/.config/autostart/bitcoin*
cd /var/lib
ln -s /media/bitcoin/.bitcoin/ bitcoind
/usr/local/bin/bitcoin-qt -disablewallet -listenonion -listen=1 -prune=0
grep "tor: Successfully connected" /media/bitcoin/.bitcoin/debug.log
watch bitcoin-cli getnetworkinfo
bitcoin-cli getconnectioncount
bitcoin-cli getpeerinfo
bitcoin-cli getpeerinfo|  grep true
bitcoin-cli getpeerinfo|  grep addr
cd ~
touch .bitcoin/bitcoin.conf
echo "txindex=1" >> .bitcoin/bitcoin.conf
echo "onlynet=onion" >> .bitcoin/bitcoin.conf
echo "maxconnections=20" >> .bitcoin/bitcoin.conf
ll /etc/bitcoin/bitcoin.conf
ll /media/bitcoin/.bitcoin/bitcoin.conf
geany /lib/systemd/system/bitcoind.service
sudo systemctl daemon-reload
sudo systemctl start bitcoind.service
./run-tor.sh
sudo systemctl restart tor
journalctl -f|  grep tor -i
tail -f /media/bitcoin/.bitcoin/debug.log
firefox bitnodes.earn.com
bitcoin-cli getnetworkinfo|  grep address
exit 0
