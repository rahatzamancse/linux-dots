#!/bin/bash
# DEPENDENCIES: tesseract-ocr imagemagick scrot

APP_NAME="Screen Reader"

export LC_ALL=en_US.UTF-8

LANG="$(echo -e "eng\nita\ndeu\nben\njpn" | rofi -dmenu -no-custom)"
if [ -z "$LANG" ]; then 
	dunstify -a "$APP_NAME" "Invalid Language" 
	exit 1
fi

echo "Language set to $LANG"

SCR_IMG=$(mktemp) # create tempfile
trap "rm $SCR_IMG*" EXIT # make sure tempfiles get deleted afterwards

#take screenshot of area
scrot -s "$SCR_IMG".png -q 100
# postprocess to prepare for OCR
mogrify -modulate 100,0 -resize 400% "$SCR_IMG".png 
# OCR in given language
tesseract -l "$LANG" "$SCR_IMG".png "$SCR_IMG"
xsel -bi < "$SCR_IMG".txt # pass to clipboard
dunstify -a "$APP_NAME" "Text Copied to clipboard"
