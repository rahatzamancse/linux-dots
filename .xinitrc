#!/bin/sh

# load appearance settings
# To see whats loaded, use `xrdb -query -all`
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

## This is required if flatpak is installed
## see https://bbs.archlinux.org/viewtopic.php?id=224787
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# run the xinitrc.d files
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Session name
export DESKTOP_SESSION=bspwm
# No tty
export XDG_SESSION_TYPE=x11
export XDG_SESSION_DESKTOP=bspwm
export XDG_CURRENT_DESKTOP=bspwm

exec bspwm
