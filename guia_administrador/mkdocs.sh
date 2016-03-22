#!/bin/bash

if [ -e ./node_modules/.bin/markdown-pdf ]; then
  MDPDF=./node_modules/.bin/markdown-pdf
else
  MDPDF=/usr/bin/markdown-pdf
fi

PAPER="-f Letter"
RUNNINGS="-h /home/ecelis/Projects/justice-league/docs/runnings.js"
CSS="-s lexsys.css"

markdown-pdf $PAPER $RUNNINGS $CSS \
  -o LexSys_GuiaInstalacion.pdf LexSys_GuiaInstalacion.md
