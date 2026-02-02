#!/bin/bash
sudo apt-get install texlive-full fonts-font-awesome
sudo apt-get install texlive texlive-latex-extra texlive-lang-french
pdflatex -synctex=1 -interaction=nonstopmode *.tex
htlatex cv-aandrieu-XX-XX-2021.tex
sudo apt-get install texstudio
sudo apt-get install poppler-utils
pdffonts cv-aandrieu-XX-XX-2021.pdf
sudo apt-get install python3-pygments
pdflatex -shell-escape -synctex=1 -interaction=nonstopmode code.tex
htlatex code.tex html "" -dSomeDir "--interaction=nonstopmode -shell-escape"
htlatex code.tex "ht5mathjax,charset=utf-8,NoFonts" "-utf8" -dSomeDir "--interaction=nonstopmode -shell-escape"
exit 0
