# 
#    _       ____                   
#   / |_ __ / ___|  __ _ _ __   ___ 
#   | | '_ \\___ \ / _` | '_ \ / _ \
#   | | | | |___) | (_| | | | |  __/
#   |_|_| |_|____/ \__,_|_| |_|\___|
#                                 

# Supresses fish's intro message
set fish_greeting

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
      case "!"
        commandline -t $history[1]; commandline -f repaint
      case "*"
        commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
      case "!"
        commandline -t ""
        commandline -f history-token-search-backward
      case "*"
        commandline -i '$'
  end
end
# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end


### ALIASES ###
alias clear="clear; figlet 'G U L U' | lolcat"
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

