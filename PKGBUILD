# Maintainer: Rahat Zaman <rahatzamancse@gmail.com>
_dist="gnome"
pkgname=linux-dots-${_dist}-git # '-bzr', '-git', '-hg' or '-svn'
pkgver=r29.d39d3a2
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
	'neovim'
)
optdepends=(
	'baobab: desc'
	'yaru-sound-theme: desc'
	'bitwarden: desc'
	'bleachbit: desc'
	'capitaine-cursors: desc'
	'celluloid: desc'
	'chrome-gnome-shell: desc'
	'clipgrab: desc'
	'conky: Profile Desktop Widgets'
	'conky: Profile Desktop Widgets'
	'crow-translate: desc' # AUR
	'dconf-editor: desc'
	'discord: desc'
	'docker: desc'
	'popsicle: desc'
	'evince: desc'
	'file-roller: desc'
	'flameshot: Best Screenshot Taker for X11'
	'folder-color-bzr: desc' # AUR
	'font-manager: desc'
	'gcolor3: desc'
	'geary: desc'
	'gnome-clocks: desc'
	'nodejs: desc'
	'pace: desc'
	'gnome-tweaks: desc'
	'gthumb: desc'
	'jre-openjdk: desc'
	'jdk-openjdk: desc'
	'git-nautilus-icons: desc' # AUR
	'gitkraken: desc' # AUR
	'gnome-shell-extension-clipboard-indicator: desc' # AUR
	'gnome-shell-extension-emoji-selector-git: desc' # AUR
	'gnome-shell-extension-system-monitor-git: desc' # AUR
	'gnome-shell-extension-no-annoyance-git: desc' # AUR
	'gnome-calendar: desc'
	'gnome-disk-utility: desc'
	'google-chrome: desc'
	'gtkhash-nautilus: desc'
	'gufw: desc'
	'handbrake: desc'
	'htop: Process Monitor'
	'hugo: desc'
	'ibus-mozc: desc'
	'matcha-gtk-theme: desc'
	'meld: desc'
	'nautilus-admin: desc'
	'nautilus-compare: desc' # AUR
	'nautilus-copy-path: desc' # AUR
	'nautilus-empty-file: desc'
	'neofetch: desc'
	'nethogs: desc'
	'noto-fonts: desc'
	'noto-fonts-extra: desc'
	'noto-fonts-cjk: desc'
	'upwork: desc' # AUR
	'openbangla-keyboard-bin: desc'
	'papirus-icon-theme: desc'
	'pavucontrol: desc'
	'peek: desc'
	'python-pip: desc'
	'rofi: desc'
	'screenkey: desc'
	'simplescreenrecorder: desc'
	'telegram-desktop: desc'
	'tesseract-data-ben: desc'
	'tesseract-data-eng: desc'
	'tesseract-data-jpn: desc'
	'tesseract: desc'
	'transmission-gtk: desc'
	'ttf-jetbrains-mono: Best monospace font for coding'
	'virtualbox-guest-iso: desc'
	'virtualbox: desc'
	'visual-studio-code-bin: desc'
	'wps-office: desc'
	'zoom: desc'
	'qalculate-gtk: desc'
	'scrot: desc'
	'skypeforlinux-stable-bin: desc'
	'gnome-sound-recorder: desc'
	'sushi: desc'
	'hardinfo: desc'
	'texlive-bibtexextra: desc'
	'texlive-bin: desc'
	'texlive-core: desc'
	'texlive-fontsextra: desc'
	'texlive-formatextra: desc'
	'texlive-latexextra: desc'
	'texlive-pictures: desc'
	'texlive-science: desc'
	'tilix: desc'
	'gnome-weather: desc'
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
source=('git+https://github.com/rahatzamancse/linux-dots#branch=master')
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

package() {
	cd "$srcdir/${pkgname%-${_dist}-git}/etc/skel"
	for file in $(find . -type f); do
		install -m 644 -D ${file} "$pkgdir/etc/skel/${file}"
	done
}
