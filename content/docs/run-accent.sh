#!/bin/sh
echo "keycode 115 = Multi_key" | xmodmap -

# See https://askubuntu.com/questions/358/how-can-i-type-accented-characters-like-%C3%AB

# https://forum.ubuntu-fr.org/viewtopic.php?id=6125
# Pour info, il peut être utile de vérifier si la touche de composition n'est pas désactivée. C'était le cas lors de mon installation d'Ubuntu 16.04.
# Pour cela, aller dans Clavier --> Saisie --> Touche de composition, et changer le Désactivé par autre chose (j'ai choisi Ctrl gauche).
##### Ubuntu 16.04
# Typing -> Compose Key -> Right Win
##### Ubuntu 20
# https://help.ubuntu.com/community/ComposeKey
# Open the Activities overview and start typing Tweak
# Compose Key -> Right Ctrl

# https://en.wikipedia.org/wiki/Compose_key#Common_compose_combinations

echo "Compose e ' = é"
echo "Compose E ' = É"
echo "Compose , c = ç"
echo "Compose ^ e = ê"
echo "..."
echo "echo "Compose o e = œ"
Compose s s  = ß"
echo "Compose ? ? = ¿"
echo "Compose << = «"

#On Ubuntu 18.04
sudo apt install gnome-tweaks

sudo apt install gnome-user-docs-fr \
  language-pack-fr \
  gimp-help-en \
  libreoffice-help-fr \
  hunspell-en-za \
  libreoffice-l10n-fr \
  language-pack-gnome-fr \
  libreoffice-help-en-gb \
  hunspell-en-ca \
  gimp-help-fr \
  hyphen-en-gb \
  hunspell-en-gb \
  firefox-locale-fr \
  mythes-en-au \
  hunspell-en-au \
  gnome-getting-started-docs-fr \
  hyphen-en-ca \
  chromium-browser-l10n \
  wfrench \
  hyphen-fr \
  libreoffice-l10n-en-gb \
  mythes-fr \
  libreoffice-l10n-en-za

exit 0
