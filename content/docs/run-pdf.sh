#!/bin/bash
set -xv
convert -compress jpeg images_*.png document.pdf
convert -density 200x200 -quality 60 -compress jpeg input.pdf output.pdf
sudo apt install xournal
sudo snap install pdftk
pdftk file1.pdf file2.pdf cat output mergedfile.pdf
sudo apt-get install pdfarranger
sudo apt-get install poppler-utils
sudo apt-get install xournal
xournal modele-courrier-declaration-sinistre.pdf
exit 0
