yay -Rs manjaro-zsh-config
yay -Rns $(pacman -Qtdq)

yay -S --needed bc betterlockscreen bspwm xorg-xbacklight xorg-xinput blueman bluez-utils dex dunst dunstify conky feh figlet lolcat flameshot gnome-keyring greenclip hibernator htop tlp ttf-jetbrains-mono tesseract tesseract-data-eng tesseract-data-jpn tesseract-data-ben jq kitty lsd nautilus networkmanager network-manager-applet noto-fonts powertop pamac papirus-icon-theme pulseaudio pulseaudio-bluetooth pavucontrol picom-ibhagwan-git python-pywal polybar rofi rofi-search-git googler rofi-calc rofi-dmenu rofimoji rofi-file-browser-extended rofi-greenclip rofi-scripts rofi-top sxhkd sysstat ttf-breeze-sans udiskie neovim wmname wpgtk xdg-user-dirs xdo xdotool xorg-xev xorg-xinit xorg-xsetroot xfce4-settings xfce-polkit xfce4-power-manager xfce4-panel yay zsh zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k zsh-auto-notify zsh-you-should-use

xdg-user-dirs-update
yay -Rns $(pacman -Qtdq)
