#!/bin/bash
set -xv
If you need to/can run them in parallel, you can create a Linux parallel command.
For instance:
find ./Programs -type f -name \*.sh|  parallel -j 4 echo "hello {}"
You can change it to:
cat $FILE_TO_PROCESS|  parallel -j 4 bash_calls_api.sh {}
FILE_TO_PROCESS
--type=treaty --id 3911
--type=treaty --id 3912
--type=treaty --id 3915
bash_call_api.sh
php bin/console jm:index:references $1
exit 0
