#!/bin/bash
#set -x

# See https://github.com/rafatosta/zapzap/releases

pip install PyQt6 PyQt6-WebEngine
sudo apt install flatpak
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user --assumeyes flathub org.kde.Platform//6.2 org.kde.Sdk//6.2 io.qt.qtwebengine.BaseApp//6.2

sudo apt install flatpak-builder
flatpak-builder build com.rtosta.zapzap.yaml --force-clean --ccache --install --user

exit 0
