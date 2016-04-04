#!/bin/bash

CWD=$(pwd)
OUTDIR=$CWD/out
FORMATS="docx html pdf"
DOCS="faq.md escritorio_manual/index.md editor_manual/editor.md portal_manual/portal.md instalacion_guia/LexSys_GuiaInstalacion.md"

if [ -d $OUTDIR ]; then
  rm -rf $OUTDIR
fi
mkdir $OUTDIR

function process_document {
  pandoc $1.md --toc -f markdown -s -o $OUTDIR/$1.$2
}

## FAQ
for format in $FORMATS; do
  process_document faq $format
done

## Desk
cd $CWD/escritorio_manual
for format in $FORMATS; do
  process_document index $format
done

## Editor
cd $CWD/editor_manual
for format in $FORMATS; do
  process_document editor $format
done

## Portal
cd $CWD/portal_manual
for format in $FORMATS; do
  process_document portal $format
done

## Instalación
cd $CWD/instalacion_guia
for format in $FORMATS; do
  process_document LexSys_GuiaInstalacion $format
done
