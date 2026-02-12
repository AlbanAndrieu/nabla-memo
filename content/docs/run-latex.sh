#!/bin/bash
#set -xv

# See https://github.com/moderncv/moderncv/blob/master/.github/workflows/build-pdf.yml

sudo apt-get install texlive-full fonts-font-awesome

sudo apt-get install texlive texlive-latex-extra texlive-lang-french
sudo apt-get install texlive-xetex

#sudo apt-get install texmaker
#texmaker cv-aandrieu-XX-XX-2021.tex

pdflatex -synctex=1 -interaction=nonstopmode *.tex
#pdflatex cv-aandrieu-02-07-2020.tex
htlatex cv-aandrieu-XX-XX-2021.tex

# See https://doc.ubuntu-fr.org/texstudio
sudo apt-get install texstudio
#sudo apt-get install latexila

#sudo apt-get install pandoc
#pandoc -s cv-aandrieu-XX-XX-2021.tex -o example2.html

sudo apt-get install poppler-utils
#pdftohtml cv-aandrieu-XX-XX-2021.pdf example2.html
pdffonts cv-aandrieu-XX-XX-2021.pdf

sudo apt-get install python3-pygments

pdflatex -shell-escape -synctex=1 -interaction=nonstopmode code.tex
htlatex code.tex html "" -dSomeDir "--interaction=nonstopmode -shell-escape"
htlatex code.tex "ht5mathjax,charset=utf-8,NoFonts" "-utf8" -dSomeDir "--interaction=nonstopmode -shell-escape"

# template
https://www.overleaf.com/latex/templates/tagged/cv
https://www.latextemplates.com/template/freeman-cv

exit 0
