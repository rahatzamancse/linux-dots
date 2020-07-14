yay -Rs manjaro-zsh-config
yay -Rns $(pacman -Qtdq)

yay -S --needed arandr autorandr betterlockscreen bspwm xorg-xbacklight blueman bluez-utils dex dunst dunstify feh figlet lolcat flameshot gnome-keyring greenclip hibernator htop tlp ttf-jetbrains-mono jq kitty lsd nautilus networkmanager network-manager-applet noto-fonts powertop pamac papirus-icon-theme pulseaudio pulseaudio-bluetooth pavucontrol picom python-pywal mate-polkit polybar rofi rofi-calc rofi-dmenu rofimoji rofi-file-browser-extended rofi-greenclip rofi-scripts sxhkd sysstat ttf-breeze-sans udiskie vim vimb xdg-user-dirs xdo xdotool xorg-xev xorg-xinit xorg-xsetroot yay zsh zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k zsh-auto-notify zsh-you-should-use

yay -Rns $(pacman -Qtdq)
xdg-user-dirs-update
