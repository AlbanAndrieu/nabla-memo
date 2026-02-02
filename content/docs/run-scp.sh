#!/bin/bash
set -xv
scp -r ubuntu@graansible01:/tmp/temp_document_dump.csv /home/albanandrieu/Downloads
scp -r ubuntu@gra1se1:/tmp/nablase_20230122_1809-01.json .
cd /home/albandrieu/Documents/job/nabla/notion
scp -r albanandrieu@albandrieu-Latitude-5420:/home/albanandrieu/Documents/Notion* .
echo "scp -S ~/scp_gra1nablabastion <path_to_file> <user>@gra1nabla1:/var/www/<user_repo>/<project>"
scp -S ~/scp_gra1nablabastion /home/albanandrieu/Downloads/test-TODELETE.pdf aandrieu@gra1nabla1:/tmp/
exit 0
