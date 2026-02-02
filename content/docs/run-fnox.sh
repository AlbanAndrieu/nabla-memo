#!/bin/bash
set -xv
./run-mise.sh
mise use -g fnox
fnox init
fnox set DATABASE_URL "postgresql://localhost/mydb"
fnox get DATABASE_URL
fnox exec -- npm start
eval "$(fnox activate bash)"
---------
✓ Created new fnox configuration at 'fnox.toml'
exit 0
