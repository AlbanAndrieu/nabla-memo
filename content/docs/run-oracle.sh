#!/bin/bash
set -xv
sudo su -
apt-get install alien libaio1 unixodbc
sudo alien -i oracle-instantclient12.2*-basic-*.rpm
sudo alien -i oracle-instantclient12.2*-devel-*.rpm
sudo alien -i oracle-instantclient12.2*-sqlplus-*.rpm
echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle.conf
sudo ldconfig
export ORACLE_CLIENT_HOME=/usr/lib/oracle/12.2/client64
export LD_LIBRARY_PATH=$ORACLE_CLIENT_HOME/lib:$LD_LIBRARY_PATH
export PATH=$ORACLE_CLIENT_HOME/bin:$PATH
lsnrctl status
lsnrctl start
lsnrctl stop
cd $ORACLE_HOME/NETWORK/ADMIN
AddVMOption -Duser.language=en
$TNS_ADMIN
show pagesize
set pagesize 50000
set linesize 9999
select * from dba_datapump_jobs
select 'drop table'||  owner_name||  '.'||  job_name||  ';' from dba_datapump_jobs
set ORACLE_HOSTNAME=albandri.nabla.mobi
set ORACLE_UNQNAME=oracle
emctl status dbconsole
dbca
docker pull store/oracle/database-instantclient:12.2.0.1
docker pull store/oracle/database-enterprise:12.2.0.1
docker run --name database-enterprise -p 1521:1521 -p 5500:5500 -v /opt/oracle/scripts/startup store/oracle/database-enterprise:12.0.1
docker exec -ti database-enterprise /bin/bash
/opt/oracle/instantclient_12_2/sqlplus sys/Oradoc_db1@//localhost:1521/ORCLCDB.localdomain as sysdba
sqlplus sys/Test123\$@//10.21.188.31:1521/ORCLPDB1 as sysdba
exit 0
