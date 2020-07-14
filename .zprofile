# $HOME/.profile

# I like a bigger cursor
export XCURSOR_SIZE=64
export QT_QPA_PLATFORMTHEME=qt5ct

# XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME="$HOME/.cache"

# File locations
export ZDOTDIR=$HOME/.config/zsh

export XAUTHORITY=$HOME/.config/Xauthority
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# DATA:
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# VIM
export VIMINIT='source $MYVIMRC'
export MYVIMRC='$HOME/.config/vimrc'

# Other configs locations
export LESSHISTFILE=$HOME/.cache/lesshst

# My defaults
export GUI_EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/google-chrome-stable
export TERM=xterm-kitty
export TERMINAL=/usr/bin/kitty
export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export EXPLORER=/usr/bin/nautilus
export LAUNCHER=$HOME/.config/rofi/launch.sh

# Primary network adapter name
# Can be found with `ip addr`
export PRIMARY_NETWORK_ADAPTER=wlp2s0

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
