# $HOME/.profile

export AMD_VULKAN_ICD=RADV
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export MAIL=geary
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# I like a bigger cursor
export XCURSOR_SIZE=64

# JAVA_HOME to jdk
export JAVA_HOME="/usr/lib/jvm/default"

# XDG variables, see https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"

# File locations
export ZDOTDIR=$HOME/.config/zsh

# export XAUTHORITY=$HOME/.config/Xauthority
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

export STARSHIP_CONFIG="$HOME/.config/starship.toml"


### ALIASES ###
alias clear="/bin/clear; figlet 'G U L U' | lolcat"
alias grubup="sudo update-grub"
alias orphaned="sudo pacman -Rns (pacman -Qtdq)"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias please='sudo'
alias gulu="figlet 'Prapti'"
alias prapti="figlet 'Gulu'"
alias putu="figlet 'Rahat'"
alias rahat="figlet 'Putu'"
alias fucking='sudo'
alias ls=lsd
alias dotfiles='/usr/bin/git --git-dir=$HOME/.linux-dots/.git --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
alias rmpclock='sudo rm /var/lib/pacman/db.lck'
alias diff=vimdiff
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias tb="nc termbin.com 9999"
alias mirrorsup='sudo reflector --latest 200 --verbose --age 12 --download-timeout 60 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias pacnews='find /etc -regextype posix-extended -regex ".+\.pac(new|save)" 2> /dev/null'


### API Tokens
[ -f $HOME/.config/API_TOKENS ] && source $HOME/.config/API_TOKENS

