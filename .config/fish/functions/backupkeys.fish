# Backup Gnome Keybindings
function backupkeys
    dconf dump / | sed -n '/\[org.gnome.settings-daemon.plugins.media-keys/,/^$/p' > ~/.linux-dots/dconf/custom-shortcuts.conf
end
