#!/bin/bash
#set -xv

# https://www.reorproject.org/downloads

chmod +x /home/albandrieu/Downloads/Reor_0.1.57.AppImage
mv /home/albandrieu/Downloads/Reor_0.1.57.AppImage /data/reor/

sudo mkdir /data/reor
sudo chown -R albandrieu:albandrieu /data/reor

/data/reor/Reor_0.1.57.AppImage

exit
