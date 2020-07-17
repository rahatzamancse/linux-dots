#! /bin/sh

## TODO: Emojify all display labels
rofi \
	-modi combi,file-browser,"CALC:qalc +u8 -nocurrencies","CLIPBOARD:greenclip print",run \
	-show combi \
	-combi-modi window,drun \
	-display-combi APPS \
	-display-drun "" \
	-display-window "󰖯" \
	-display-file-browser FILES \
	-display-run SHELL \
	-columns 2 \
