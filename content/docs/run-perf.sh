#!/bin/bash
set -xv
sudo apt-get install siege
sudo siege -t40S-c30 82.66.4.247
siege -b -v -t 60S -c1 https://jm-ksdifu78gwc45gv1s0jshgtr764jnb79.lexsportiva.tech/en/api/current-user
curl -fsSL $BETTERUPTIME_URL
siege -b -v -t 60S -c1 http://10.20.0.37:26004/api/search
siege -b -v -t 60S -c1 https://jm-frontnuxt.dev.int.jusmundi.com/en/partnership/icc
siege -b -v -t 60S -c1 https://front.dev.int.jusmundi.com/en/test?query=tatat
siege -b -v -t 60S -c1 https://jm-frontnuxt.dev.int.jusmundi.com/en/document/publication/en-arbitrator-disclosure
sudo apt-get install apache2-utils
ab -n 10000 -c 1000 https://front.service.gra.dev.consul/fr/login
ab -n 10000 -c 10000 http://10.30.0.115:20954/
/home/albanandrieu/w/jm/fastapi-sample/scripts/run-locus.sh
sudo hdparm --direct -t -T /dev/nvme0n1
/dev/nvme0n1:
Timing O_DIRECT cached reads: 1158 MB in 2.00 seconds = 578.30 MB/sec
Timing O_DIRECT disk reads: 1240 MB in 3.03 seconds = 408.86 MB/sec
sudo apt install fio ioping
echo "Testing: Random read/write performance"
fio --name=randreadwrite --ioengine=libaio --iodepth=1 --readwrite=randrw --rwmixread=75 -bs=4k --direct=1 --size=512M --numjobs=8 --runtime=240 --group_reporting
echo ""
echo "Testing: Random read performance"
fio --name=randread --ioengine=libaio --iodepth=1 --readwrite=randread -bs=4k --direct=1 --size=512M --numjobs=8 --runtime=240 --group_reporting
echo ""
echo "Testing: Random write performance"
fio --name=randwrite --ioengine=libaio --iodepth=1 --readwrite=randwrite -bs=4k --direct=1 --size=512M --numjobs=8 --runtime=240 --group_reporting
echo ""
echo "Testing: IO Latency on individual request"
ioping -c 10 .
./run-perf-monitoring-install.sh
exit 0
