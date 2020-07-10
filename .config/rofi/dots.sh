#!/bin/bash

# Options
DOTS_GIT=$HOME/.dots-git/git-control/.git

dotfile_paths=$(/usr/bin/git --git-dir=$DOTS_GIT --work-tree=$HOME ls-tree -r master --name-only)

chosen="$(echo -e "$dotfile_paths" | rofi -dmenu)"
$VISUAL $chosen
