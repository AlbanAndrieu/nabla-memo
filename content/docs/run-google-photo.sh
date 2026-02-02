#!/bin/bash
set -xv
19 / Google Photos
http://127.0.0.1:53682
https://truenas.albandrieu.com
https://freenas.albandrieu.com
https://albandrieu.albandrieu.com
http://localhost:53682/auth/google/callback
https://truenas.albandrieu.com/auth/google/callback
https://freenas.albandrieu.com/auth/google/callback
https://albandrieu.albandrieu.com/auth/google/callback
pip install gphotos-sync
rclone lsd GooglePhotos:album
ll .config/rclone/rclone.conf
rclone lsd gphoto:album
- https://www.googleapis.com/auth/photoslibrary.appendonly
- https://www.googleapis.com/auth/photoslibrary.readonly.appcreateddata
- https://www.googleapis.com/auth/photoslibrary.edit.appcreateddata
exit 0
