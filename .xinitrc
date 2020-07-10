#!/bin/sh

# Setting the resolution correctly
# using `cvt 1920 1080 60`
xrandr --newmode "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 1920x1080_60.00
xrandr --output Virtual1 --mode 1920x1080_60.00

# load appearance settings
xrdb merge .Xresources &

# I have not much knowledge about gnome-keyring and ssh together.
# It seems that without this variable SSH_AUTH_SOCK, I dont face any problem.
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK

exec bspwm
