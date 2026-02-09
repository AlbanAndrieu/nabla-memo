#!/bin/bash
set -xv

# fix local

#  warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
# perl: warning: Setting locale failed.
# perl: warning: Please check that your locale settings:
# 	LANGUAGE = "en_US.UTF-8",
# 	LC_ALL = "en_US.UTF-8",
# 	LC_ADDRESS = "fr_FR.UTF-8",
# 	LC_NAME = "fr_FR.UTF-8",
# 	LC_MONETARY = "fr_FR.UTF-8",
# 	LC_PAPER = "fr_FR.UTF-8",
# 	LC_IDENTIFICATION = "fr_FR.UTF-8",
# 	LC_TELEPHONE = "fr_FR.UTF-8",
# 	LC_MESSAGES = "en_US.UTF-8",
# 	LC_MEASUREMENT = "fr_FR.UTF-8",
# 	LC_CTYPE = "en_US.UTF-8",
# 	LC_TIME = "fr_FR.UTF-8",
# 	LC_NUMERIC = "fr_FR.UTF-8",
# 	LANG = "en_US.UTF-8"
#     are supported and installed on your system.
# perl: warning: Falling back to the standard locale ("C").

./run-locale.sh

exit 0
