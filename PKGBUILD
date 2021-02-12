# Maintainer: Rahat Zaman <rahatzamancse@gmail.com>
_dist="gnome"
pkgname=linux-dots-${_dist}-git # '-bzr', '-git', '-hg' or '-svn'
pkgver=r30.838bed2
pkgrel=1
pkgdesc="All the dot files configured to use by Rahat Zaman."
arch=('any')
url="https://github.com/rahatzamancse/linux-dots"
license=('unknown')
groups=()
depends=(
	'figlet' 'lolcat' 'lsd'
	'paru'
	'zsh' 'zsh-autosuggestions' 'zsh-completions' 'zsh-history-substring-search' 'zsh-syntax-highlighting' 'zsh-theme-powerlevel10k'
	# 'zsh-auto-notify' 'zsh-you-should-use'
	'rofi'
	'neovim'
)
optdepends=(
	'baobab: Disk Usage Monitoring'
	'bitwarden: Open Source Password Manager'
	'bleachbit: Cleaner'
	'capitaine-cursors: My Favourite Cursor Theme'
	'celluloid: Video Player based on MPV'
	'chrome-gnome-shell: To manage Gnome Extensions in Chrome'
	'clipgrab: Youtube Downloader'
	'conky: For Desktop Widgets'
	'crow-translate: Translate using multiple API' # AUR
	'dconf-editor: Gnome dconf editor'
	'discord: Discord'
	'docker: Docker'
	'evince: Default PDF reader of Gnome'
	'file-roller: Archive Manager'
	'flameshot: Best Screenshot Taker for X11'
	'folder-color-bzr: Color Folders' # AUR
	'font-manager: Powerful Fond Manager'
	'gcolor3: Color Picker'
	'geary: Mail Client'
	'git-nautilus-icons: Git status icons on files' # AUR
	'gitkraken: Git manager' # AUR
	'gnome-calendar: Gnome Calendar'
	'gnome-clocks: Gnome Clocks'
	'gnome-disk-utility: Disk Manager'
	'gnome-shell-extension-clipboard-indicator: Clipboard Manager' # AUR
	'gnome-shell-extension-emoji-selector-git: Emoji Selector' # AUR
	'gnome-shell-extension-no-annoyance-git: Removes "Windows is Ready" notification from Gnome' # AUR
	'gnome-shell-extension-system-monitor-git: System status on top-bar' # AUR
	'gnome-sound-recorder: Sound Recorder'
	'gnome-tweaks: Gnome Tweaks'
	'gnome-weather: Gnome Weather'
	'google-chrome: Google Chrome Browser'
	'gthumb: Photo Viewer'
	'gtkhash-nautilus: Hash calculator right inside nautilus'
	'gufw: Firewall'
	'handbrake: Video compressor'
	'hardinfo: System Informations'
	'htop: Process Monitor'
	'hugo: My Personal website manager'
	'ibus-mozc: Japanese Typing'
	'jdk-openjdk: JDK latest'
	'jre-openjdk: JRE latest'
	'matcha-gtk-theme: Gnome Theme'
	'meld: My Diff tool'
	'nautilus-admin: Open nautilus with sudo at CWD'
	'nautilus-compare: Compare multiple files from context menu' # AUR
	'nautilus-copy-path: Copy path of a file from context menu' # AUR
	'nautilus-empty-file: Create an empty file from context menu'
	'neofetch: Print System info in terminal'
	'nethogs: Bandwidth monitor per application'
	'nodejs: NodeJS'
	'noto-fonts-cjk: Chinese/Japanese fonts'
	'noto-fonts-extra: Extra fonts'
	'noto-fonts: All Fonts'
	'openbangla-keyboard-bin: Bangla Typing'
	'pace: Mirrorlist manager'
	'papirus-icon-theme: My favourite icon theme'
	'pavucontrol: Sound Manager'
	'peek: Screen capture as GIF'
	'popsicle: USB burner'
	'python-pip: Python package Manager'
	'qalculate-gtk: Best calculator (provides gnome search functionality)'
	'screenkey: Displays Keyboard buttons on screen when pressed'
	'scrot: Screen capturing utility'
	'simplescreenrecorder: Screen Recorder for X11'
	'skypeforlinux-stable-bin: Skype'
	'sushi: File previewer'
	'telegram-desktop: Telegram'
	'tesseract-data-ben: Bangla tesseract data'
	'tesseract-data-eng: English tesseract data'
	'tesseract-data-jpn: Japanese tesseract data'
	'tesseract: OCR engine by Google'
	'texlive-most: Latex'
	'texlive-lang: Latex non latin character support'
	'biber: Handle biblatex bibliography'
	'tilix: Best GTK terminal emulator'
	'transmission-gtk: Torrent Client'
	'ttf-jetbrains-mono: Best monospace font for coding'
	'upwork: Upwork Client' # AUR
	'virtualbox-guest-iso: Guest iso for virtualbox'
	'virtualbox: OS virtualization'
	'visual-studio-code-bin: Best code editor'
	'wps-office: Best MS office compatible office-tool for linux'
	'yaru-sound-theme: Ubuntu Sound theme'
	'zoom: Zoom client'
)
makedepends=('git')
provides=("${pkgname%-${_dist}-git}")
conflicts=("${pkgname%-${_dist}-git}")
replaces=()
backup=(
	'etc/skel/.zprofile'
	'etc/skel/.Xresources'
	'etc/skel/.Xresources'
	'etc/skel/.config/neofetch/config.conf'
	'etc/skel/.config/conky/myconky'
	'etc/skel/.config/nvim/init.vim'
	'etc/skel/.config/rofi/config.rasi'
	'etc/skel/.config/rofi/colors.rasi'
	'etc/skel/.config/zsh/.zshrc'
)
options=()
source=('git+https://github.com/rahatzamancse/${pkgname%-${_dist}-git}#branch=master')
md5sums=('SKIP')

pkgver() {
	cd "$srcdir/${pkgname%-${_dist}-git}"

# VERSION='VER_NUM.rREV_NUM.HASH', or a relevant subset in case VER_NUM or HASH
# are not available, is recommended.

# Git, no tags available
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
	cd "$srcdir/${pkgname%-${_dist}-git}"
}

build() {
	cd "$srcdir/${pkgname%-${_dist}-git}"
}

check() {
	cd "$srcdir/${pkgname%-${_dist}-git}"
}

pre_install() {
	echo "I am here!!!!"
}

package() {
	cd "$srcdir/${pkgname%-${_dist}-git}/etc/skel"
	for file in $(find . -type f); do
		install -m 644 -D ${file} "$pkgdir/etc/skel/${file}"
	done
}

