#!/bin/sh

# load appearance settings
# To see whats loaded, use `xrdb -query -all`
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

## This is required if flatpak is installed
## see https://bbs.archlinux.org/viewtopic.php?id=224787
# dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

exec bspwm
