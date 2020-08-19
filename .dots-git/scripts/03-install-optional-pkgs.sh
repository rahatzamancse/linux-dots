figlet "GETTING LOOKS"
yay -S --needed qt5ct qt5-styleplugins lxappearance-gtk3 grub-customizer capitaine-cursors neofetch font-manager

figlet "OTHERS"
yay -S --needed atop baobab clipgrab crow-translate dconf-editor entr evince file-roller folder-color-bzr gcolor3 git-nautilus-icons gitui-bit gitkraken gnome-disk-utility google-chrome gtkhash-nautilus gufw handbrake htop hugo ibus-mozc mousepad mailspring manjaro-settings-manager manjaro-settings-manager-notifier masterpdfeditor-free megasync meld minetime mpv nautilus-admin nautilus-compare nautilus-copy-path nautilus-open-any-terminal nethogs nomacs noto-fonts-cjk openbangla-keyboard-bin openshot peek python-pip seahorse simplescreenrecorder telegram-desktop transmission-gtk trilium-bin virtualbox virtualbox-guest-iso visual-studio-code-bin xfce4-settings wps-office zoom

yay -Rns $(pacman -Qtdq)
