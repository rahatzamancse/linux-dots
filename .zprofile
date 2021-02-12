# $HOME/.profile

# I like a bigger cursor
export XCURSOR_SIZE=64
export QT_QPA_PLATFORMTHEME=qt5ct

# XDG variables, see https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
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

# Other configs locations
export LESSHISTFILE=$HOME/.cache/lesshst

# My defaults
export BROWSER=/usr/bin/google-chrome-stable
export EXPLORER=/usr/bin/nautilus

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
