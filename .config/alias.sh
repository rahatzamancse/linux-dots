### ALIASES ###
alias clear="/bin/clear; figlet 'G U L U' | lolcat"
alias cat="bat"
alias du="dust"
alias grubup="sudo update-grub"
alias orphaned="sudo pacman -Rns (pacman -Qtdq)"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# alias cd="z" # This is on test

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias gitcr='git clone --recursive'
alias gitc='git clone'
alias git_myrepos='curl -s https://api.github.com/users/rahatzamancse/repos | jq -r ".[].name"'
alias please='sudo'
alias gulu="figlet 'Prapti'"
alias prapti="figlet 'Gulu'"
alias putu="figlet 'Rahat'"
alias rahat="figlet 'Putu'"
alias fucking='sudo'
alias ls=lsd
alias dotfiles='/usr/bin/git --git-dir=$HOME/.github/.git --work-tree=$HOME'
/usr/bin/git --git-dir=$HOME/.github/.git --work-tree=$HOME config --local status.showUntrackedFiles no
alias rmpclock='sudo rm /var/lib/pacman/db.lck'
alias diff=vimdiff
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias tb="nc termbin.com 9999"
# For arch linux
## alias mirrorsup='sudo reflector --latest 200 --verbose --age 12 --download-timeout 60 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
# For manjaro
alias mirrorsup='sudo pacman-mirrors -f 5'
alias pacnews='find /etc -regextype posix-extended -regex ".+\.pac(new|save)" 2> /dev/null'

alias gitignorerm='git ls-files -i -c --exclude-from=.gitignore | xargs git rm --cached'

alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias docker_clean_all='docker kill $(docker ps -q) && docker_clean_ps && docker rmi $(docker images -a -q)'
alias docker_prune_all='docker system prune -a -f'
alias pyclean="find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete"

# pass management
alias passlist="rbw list"
alias passsearch="rbw list | grep -i"
alias passadd="rbw add"
