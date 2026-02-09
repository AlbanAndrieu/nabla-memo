#!/bin/bash
set -xv

# https://www.truenas.com/docs/scale/scaletutorials/dataprotection/cloudsynctasks/addgooglephotoscloudsynctask/

# https://rclone.org/googlephotos/


19 / Google Photos

# This app is blocked
# https://www.reddit.com/r/rclone/comments/1kgcwcl/problems_with_google_photos_request_had/
# https://developers.google.com/photos/support/updates?hl=fr

# Enable Google Photos Picker API
# https://console.cloud.google.com/apis/library/photospicker.googleapis.com?hl=fr&project=nabla-01

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
# <3>ERROR : : error listing: couldn't list albums: Request had insufficient authentication scopes. (403 PERMISSION_DENIED)
# Failed to lsd with 2 errors: last error was: couldn't list albums: Request had insufficient authentication scopes. (403 PERMISSION_DENIED)

# https://rclone.org/googlephotos/

- https://www.googleapis.com/auth/photoslibrary.appendonly
- https://www.googleapis.com/auth/photoslibrary.readonly.appcreateddata
- https://www.googleapis.com/auth/photoslibrary.edit.appcreateddata

exit 0
