#!/bin/sh

filename=$1
target="$(dirname "${filename}")/../pdf"
outputFile="$(basename "$filename" .md).pdf"

mkdir -p $target

pandoc \
	--pdf-engine=pdflatex \
	-V 'mainfont:DejaVuSerif'
	-V 'mainfontoptions:Extension=.ttf, Uprightfont=*,  BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic' \
	-V 'sansfont:DejaVuSans.ttf' \
	-V 'monofont:DejaVuSansMono.ttf' \
	-V 'geometry:margin=1in' \
	-o "$target/$outputFile" $filename &
