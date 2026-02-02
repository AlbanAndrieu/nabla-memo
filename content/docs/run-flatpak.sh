#!/bin/bash
set -xv
sudo apt install flatpak --fix-missing
sudo apt install gnome-software-plugin-flatpak
sudo apt-get update
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo snap list
sudo flatpak list
flatpak info --show-permissions com.github.tchx84.Flatseal
sudo flatpak update
ll /var/lib/flatpak/exports/share
ll /home/albandrieu/.local/share/flatpak/exports/share
flatpak install flathub io.github.bytezz.IPLookup
flatpak run io.github.bytezz.IPLookup
flatpak install flathub org.gnome.Logs
sudo -i flatpak run org.gnome.Logs
flatpak install flathub io.github.arunsivaramanneo.GPUViewer
flatpak run io.github.arunsivaramanneo.GPUViewer
flatpak install flathub io.github.congard.qnvsm
flatpak run io.github.congard.qnvsm
flatpak install flathub org.deskflow.deskflow
flatpak install flathub app.drey.Dialect
flatpak install flathub flatseal
sudo flatpak repair
flatpak --user uninstall --unused
flatpak --system uninstall --unused
sudo flatpak uninstall --unused
sudo apt remove gnome-software
sudo apt autoremove
sudo apt install gnome-software
sudo flatpak -v repair --reinstall-all
sudo geany /etc/apparmor.d/bwrap
sudo systemctl reload apparmor
sudo sysctl -w kernel.apparmor_restrict_unprivileged_unconfined=0
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
flatpak run com.slack.Slack
flatpak run com.ktechpit.whatsie
./install-fonts.sh
exit 0
