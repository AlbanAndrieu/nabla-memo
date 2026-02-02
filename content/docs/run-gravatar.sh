#!/bin/bash
set -xv
echo "https://gravatar.com/albanandrieu"
node generate-gravatar.js
echo "Gravatar URL: https://www.gravatar.com/avatar/0b801dc3f41eb9fd80fd7a70416d72fdac3512986d4939c1dd0bb86c3a94fcad?s=200&d=identicon"
echo "https://gravatar.com/0b801dc3f41eb9fd80fd7a70416d72fdac3512986d4939c1dd0bb86c3a94fcad.md"
exit 0
