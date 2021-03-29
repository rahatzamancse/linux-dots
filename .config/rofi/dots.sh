#!/bin/bash

# Options
DOTS_GIT=$HOME/.linux-dots/.git

dotfile_paths=$(/usr/bin/git --git-dir=$DOTS_GIT --work-tree=$HOME ls-tree -r master --name-only)

chosen="$(echo -e "$dotfile_paths" | rofi -dmenu -no-custom)"
[ -f "$chosen" ] && tilix -e $EDITOR $chosen || dunstify "No such file"
