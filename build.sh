#!/bin/bash

CWD=$(pwd)
OUTDIR=$CWD/out
FORMATS="odt pdf"
DOCS='preguntas_frecuentes escritorio_manual editor_manual portal_manual instalacion_guia'

if [ -d $OUTDIR ]; then
  rm -rf $OUTDIR
fi
mkdir $OUTDIR

function process_document {
  echo -e "Building $2.$3\n"
  pandoc $1.md --toc -f markdown -s -o $OUTDIR/$2.$3
}

for d in $DOCS; do
  cd $CWD/$d
  rm -rf site
  mkdocs build
  cd $CWD/$d/docs
  for format in $FORMATS; do
    process_document index lexsys_$d $format
  done
done
