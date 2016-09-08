#!/bin/bash

CWD=$(pwd)
OUTDIR=$CWD/out
FORMATS="odt pdf"
DOCS="api desk editor faq instalacion portal"

if [ -d $OUTDIR ]; then
  rm -rf $OUTDIR
fi
mkdir $OUTDIR

function process_document {
  echo -e "Building $2.$3\n"
  pandoc $1.md --toc -f markdown -s -o $OUTDIR/$2.$3
}

cd $CWD
rm -rf site
mkdocs build --clean
cd $CWD/docs
for d in $DOCS; do
  for format in $FORMATS; do
    process_document $d lexsys_${d}_manual $format
  done
done
