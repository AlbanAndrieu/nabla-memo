#!/bin/bash
set -xv

./run-mise.sh

# Installer via mise (recommandé)
mise use -g fnox

# Initialiser dans votre projet
fnox init

# Définir un secret (chiffré par défaut)
fnox set DATABASE_URL "postgresql://localhost/mydb"

# Récupérer un secret
fnox get DATABASE_URL

# Exécuter des commandes avec les secrets chargés
fnox exec -- npm start

# Activer l'intégration shell (chargement automatique lors du cd)
eval "$(fnox activate bash)" # ou zsh, fish

---------

✓ Created new fnox configuration at 'fnox.toml'

# Next steps:
#   • Add secrets: fnox set MY_SECRET test1234
#   • List secrets: fnox list
#   • Use in commands: fnox exec -- <command>

exit 0
