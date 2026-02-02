#!/bin/bash
set -xv
sudo apt install libfuse2
cd ~/Downloads
mkdir -p ~/Applications
mv Cursor-0.49.5-x86_64.AppImage ~/Applications/cursor.AppImage
chmod +x ~/Applications/cursor.AppImage
~/Applications/cursor.AppImage --no-sandbox
cd ~/Applications/
wget https://raw.githubusercontent.com/rahuljangirwork/copmany-logos/refs/heads/main/cursor.png
alias cursor='~/Applications/cursor.AppImage --no-sandbox'
nano ~/.local/share/applications/cursor.desktop
[Desktop Entry]
Name=cursor
Exec=/home/albanandrieu/Applications/cursor.AppImage --no-sandbox
Icon=/home/albanandrieu/Applications/cursor.png
Type=Application
Terminal=false
curl https://cursor.com/install -fsS|  bash
code --install-extension charliermarsh.ruff
exit 0
