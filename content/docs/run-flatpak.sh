#!/bin/bash
set -xv

# See https://flatpak.org/setup/Ubuntu

sudo apt install flatpak --fix-missing
sudo apt install gnome-software-plugin-flatpak
sudo apt-get update
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo snap list

sudo flatpak list
flatpak info --show-permissions com.github.tchx84.Flatseal
sudo flatpak update

# See https://flathub.org/home

ll /var/lib/flatpak/exports/share
ll /home/albandrieu/.local/share/flatpak/exports/share

# See https://flathub.org/apps/org.fkoehler.KTailctl
# sudo rm -R /home/albanandrieu/.local/share/flatpak/
# sudo flatpak install flathub org.fkoehler.KTailctl
# flatpak run org.fkoehler.KTailctl

# https://flathub.org/apps/io.gpt4all.gpt4all
# flatpak install flathub io.gpt4all.gpt4all
# flatpak run io.gpt4all.gpt4all

flatpak install flathub io.github.bytezz.IPLookup
flatpak run io.github.bytezz.IPLookup

flatpak install flathub org.gnome.Logs
sudo -i flatpak run org.gnome.Logs

# Instead use apt : (need root access)
# flatpak install flathub com.gitlab.davem.ClamTk
# flatpak run com.gitlab.davem.ClamTk

flatpak install flathub io.github.arunsivaramanneo.GPUViewer
flatpak run io.github.arunsivaramanneo.GPUViewer

flatpak install flathub io.github.congard.qnvsm
flatpak run io.github.congard.qnvsm

# https://flathub.org/apps/org.deskflow.deskflow
flatpak install flathub org.deskflow.deskflow

# traduction https://dialectapp.org/
flatpak install flathub app.drey.Dialect

# UI to see flatpak permissions
flatpak install flathub flatseal

sudo flatpak repair

# failed to sync with dbus proxy flatpak ubuntu
flatpak --user uninstall --unused
flatpak --system uninstall --unused
sudo flatpak uninstall --unused

sudo apt remove gnome-software
sudo apt autoremove
sudo apt install gnome-software

# ldconfig failed, exit status 256
sudo flatpak -v repair --reinstall-all

sudo geany /etc/apparmor.d/bwrap
sudo systemctl reload apparmor

# https://ubuntu.com/blog/ubuntu-23-10-restricted-unprivileged-user-namespaces
sudo sysctl -w kernel.apparmor_restrict_unprivileged_unconfined=0
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0

flatpak run com.slack.Slack
flatpak run com.ktechpit.whatsie
# bwrap: Can't find source path /home/albandrieu/.local/share/fonts: No such file or directory
./install-fonts.sh

exit 0
