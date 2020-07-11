#!/bin/sh

# Setting the resolution correctly
# using `cvt 1920 1080 60`
xrandr --newmode "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
xrandr --addmode $PRIMARY_MONITOR 1920x1080_60.00
xrandr --output $PRIMARY_MONITOR --mode 1920x1080_60.00

# load appearance settings
xrdb merge .Xresources &

exec bspwm
