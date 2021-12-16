# 
#    _       ____                   
#   / |_ __ / ___|  __ _ _ __   ___ 
#   | | '_ \\___ \ / _` | '_ \ / _ \
#   | | | | |___) | (_| | | | |  __/
#   |_|_| |_|____/ \__,_|_| |_|\___|
#                                 

source $HOME/.profile

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

# Backup Gnome Keybindings
function backupkeys
    dconf dump / | sed -n '/\[org.gnome.settings-daemon.plugins.media-keys/,/^$/p' > ~/.linux-dots/dconf/custom-shortcuts.conf
end

# Ask user for confirmation
function read_confirm
  while true
    read -l -P "$argv[1] [y/N] " confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

function pyclean
    find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
end



# Diff pacnews with meld
function pacnewsdiff
    sudo meld $argv[1] $argv[1].pacnew
    if read_confirm 'Do you want to delete the pacnew?'
        sudo rm $argv[1].pacnew
    end
end

starship init fish | source
figlet 'G U L U' | lolcat
