#!/bin/bash

[ -d /tmp/qrgen ] || mkdir /tmp/qrgen
qrencode -o /tmp/qrgen/clip.png "$(xclip -o)" && sushi /tmp/qrgen/clip.png
