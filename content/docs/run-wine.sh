#!/bin/bash
set -xv
sudo add-apt-repository ppa:ubuntu-wine/ppa
sudo apt-get update
sudo apt-get upgrade
rm -rf ~/.wine
sudo apt-get install wine1.2
sudo apt-get build-dep wine
wine BridgitLoader.exe
wine /workspace/users/albandri10/.wine/drive_c/users/albandri/Application\ Data/SMART\ Technologies/Bridgit/4.6.206.0/Bridgit.exe
wineconsole /workspace/users/albandri10/.wine/drive_c/users/albandri/Application\ Data/SMART\ Technologies/Bridgit/4.6.206.0/Bridgit.exe
wine /home/albandri/.wine/drive_c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe
winecfg
ls -lrta $HOME/.wine/drive_c/
sudo apt install playonlinux
wineconsole ./target/bin/x86Linux/run_app.exe
sudo apt remove wine playonlinux
sudo apt-get remove --autoremove wine-* libwine-development
sudo apt remove libwine wine32 wine64 fonts-wine
dpkg -l|  egrep "(wine|playonlinux)"|  awk '{print $2}'
exit 0
