#!/bin/bash
set -xv
echo "Symantec Endpoint Protection : SAVFL"
chmod +x ./install.sh
sudo ./install.sh
cd /opt/Symantec/symantec_antivirus/
/opt/Symantec/symantec_antivirus/sav info -d
sudo /opt/Symantec/symantec_antivirus/sav info -s
/opt/Symantec/symantec_antivirus/sav info -p
/opt/Symantec/symantec_antivirus/sav info -e
/opt/Symantec/symantec_antivirus/sav manage -p
/opt/Symantec/symantec_antivirus/sav manage -s
/opt/Symantec/symantec_antivirus/sav info -a
sudo /opt/Symantec/symantec_antivirus/sav liveupdate -u
sudo /etc/init.d/rtvscand restart
sudo bash ./sadiag.sh
sudo /opt/Symantec/symantec_antivirus/sav scheduledscan -c albandri -f weekly -i Sat -t 23:00 -m 1 /
sudo /opt/Symantec/symantec_antivirus/sav scheduledscan --list
sudo /opt/Symantec/symantec_antivirus/sav manualscan --clscan /&
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 70
sudo update-alternatives --config gcc
sudo update-alternatives --config g++
find . -name 'ap-kernelmodule*'
./build.sh --kernel-dir /lib/modules/$(uname -r)/build
cp ./bin.ira/* /opt/Symantec/autoprotect
sudo /etc/init.d/autoprotect restart
sudo /etc/init.d/rtvscand restart
dmesg|  tail -n 2
/opt/Symantec/symantec_antivirus/sav info -a
sudo apt-get purge $(dpkg -l|  awk '{print $2}'|  grep -E "linux-(image|headers)-$(uname -r|  cut -d- -f1).*")
apt --fix-broken install
pkill savtray
sudo /etc/init.d/rtvscand stop
sudo /etc/init.d/symcfgd stop
sudo /etc/init.d/smcd stop
/opt/Symantec/symantec_antivirus/unsupported/xsymcfg --help
ls -lrta /etc/symantec/sep
export PATH=$PATH:/opt/Symantec/symantec_antivirus/
/opt/Symantec/symantec_antivirus/symcfg -r list
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Storages\FileSystem\RealTimeScan' -v HaveExceptionDirs -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\LocalScans\ManualScan' -v HaveExceptionDirs -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Custom Tasks\albandri' -v HaveExceptionDirs -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Storages\FileSystem\RealTimeScan\NoScanDir' -v /proc -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Storages\FileSystem\RealTimeScan\NoScanDir' -v /sys -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\LocalScans\ManualScan\NoScanDir' -v /proc -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\LocalScans\ManualScan\NoScanDir' -v /sys -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Custom Tasks\albandri\NoScanDir' -v /proc -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Custom Tasks\albandri\NoScanDir' -v /sys -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Storages\FileSystem\RealTimeScan\NoScanDir' -v /kgr -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Storages\FileSystem\RealTimeScan\NoScanDir' -v /home -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\LocalScans\ManualScan\NoScanDir' -v /kgr -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\LocalScans\ManualScan\NoScanDir' -v /home -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Custom Tasks\albandri\NoScanDir' -v /kgr -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg add -k '\Symantec Endpoint Protection\AV\Custom Tasks\albandri\NoScanDir' -v /home -d 1 -t REG_DWORD
/opt/Symantec/symantec_antivirus/symcfg -r list|  grep 'proc\|sys\|kgr\|home'
tail -f /var/symantec/sep/Logs/syslog.log
/opt/Symantec/symantec_antivirus/sav log -e
exit 0
