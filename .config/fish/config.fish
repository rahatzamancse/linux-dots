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

starship init fish | source

if status --is-login
	figlet 'G U L U' | lolcat
end

zoxide init --cmd cd fish | source

pyenv init - | source
