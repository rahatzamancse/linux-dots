export PATH="$PATH:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$HOME/.local/share/bin"

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/:/var/lib/flatpak/exports/share/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR=$HOME/.config/zsh
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export LESSHISTFILE=$HOME/.cache/lesshst

[ -f "$HOME/.config/secrets.sh" ] && source "$HOME/.config/secrets.sh"
[ -f "$HOME/.config/alias.sh" ] && source "$HOME/.config/alias.sh"
