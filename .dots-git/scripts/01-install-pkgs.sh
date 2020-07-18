yay -Rs manjaro-zsh-config
yay -Rns $(pacman -Qtdq)

yay -S --needed arandr autorandr betterlockscreen bspwm xorg-xbacklight xorg-xinput blueman bluez-utils dex dunst dunstify feh figlet lolcat flameshot gnome-keyring greenclip hibernator htop tlp ttf-jetbrains-mono jq kitty lsd nautilus networkmanager network-manager-applet noto-fonts powertop pamac papirus-icon-theme pulseaudio pulseaudio-bluetooth pavucontrol picom-ibhagwan-git python-pywal mate-polkit polybar rofi rofi-calc rofi-dmenu rofimoji rofi-file-browser-extended rofi-greenclip rofi-scripts sxhkd sysstat ttf-breeze-sans udiskie vim vimb wmname wpgtk xdg-user-dirs xdo xdotool xorg-xev xorg-xinit xorg-xsetroot xsettingsd yay zsh zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k zsh-auto-notify zsh-you-should-use

xdg-user-dirs-update
yay -Rns $(pacman -Qtdq)
