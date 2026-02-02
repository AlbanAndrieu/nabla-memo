#!/bin/bash
set -xv
docker pull microsoft/mssql-server-linux:latest
sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourStrong!Passw0rd>' \
  -e "MSSQL_PID=developer"
-p 1433:1433 --name sql1 \
  -d microsoft/mssql-server-linux:latest
docker exec -it sql1 "bash"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '<YourStrong!Passw0rd>'
docker pull microsoft/mssql-tools:latest
exit 0
