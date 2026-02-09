#!/bin/bash
set -xv

sudo apt-get install siege

# Pour exécuter le test pendant 40 secondes et 30 utilisateurs simultanés, utilisez le format ci-dessous :
sudo siege -t40S-c30 82.66.4.247

siege -b -v -t 60S -c1 https://jm-ksdifu78gwc45gv1s0jshgtr764jnb79.lexsportiva.tech/en/api/current-user

# See https://betteruptime.com/
curl -fsSL ${BETTERUPTIME_URL}

# curl --connect-timeout 2 -XGET http://10.20.0.37:26004/api/search -w "%{time_connect},%{time_total},%{speed_download},%{http_code},%{size_download},%{url_effective}\n" -o /dev/null -s

siege -b -v -t 60S -c1 http://10.20.0.37:26004/api/search
siege -b -v -t 60S -c1 https://jm-frontnuxt.dev.int.jusmundi.com/en/partnership/icc
siege -b -v -t 60S -c1 https://front.dev.int.jusmundi.com/en/test?query=tatat
siege -b -v -t 60S -c1 https://jm-frontnuxt.dev.int.jusmundi.com/en/document/publication/en-arbitrator-disclosure

# Apache Benchmark
sudo apt-get install apache2-utils

ab -n 10000 -c 1000 https://front.service.gra.dev.consul/fr/login

ab -n 10000 -c 10000 http://10.30.0.115:20954/

# See locus
/home/albanandrieu/w/jm/fastapi-sample/scripts/run-locus.sh

# lsblk -o NAME,SIZE,GROUP,TYPE,FSTYPE,MOUNTPOIN

sudo hdparm --direct -t -T /dev/nvme0n1

/dev/nvme0n1:
Timing O_DIRECT cached reads: 1158 MB in 2.00 seconds = 578.30 MB/sec
Timing O_DIRECT disk reads: 1240 MB in 3.03 seconds = 408.86 MB/sec

sudo apt install fio ioping

echo "Testing: Random read/write performance"
#fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75
fio --name=randreadwrite --ioengine=libaio --iodepth=1 --readwrite=randrw --rwmixread=75 -bs=4k --direct=1 --size=512M --numjobs=8 --runtime=240 --group_reporting

echo ""
echo "Testing: Random read performance"
#fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randread
fio --name=randread --ioengine=libaio --iodepth=1 --readwrite=randread -bs=4k --direct=1 --size=512M --numjobs=8 --runtime=240 --group_reporting

echo ""
echo "Testing: Random write performance"
#fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randwrite
fio --name=randwrite --ioengine=libaio --iodepth=1 --readwrite=randwrite -bs=4k --direct=1 --size=512M --numjobs=8 --runtime=240 --group_reporting

echo ""
echo "Testing: IO Latency on individual request"
ioping -c 10 .

./run-perf-monitoring-install.sh

exit 0
