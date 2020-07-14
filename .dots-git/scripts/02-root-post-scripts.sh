#! /bin/sh
# For gnome-keyring, pam method (see archwiki)
echo "password	optional	pam_gnome_keyring.so" >> /etc/pam.d/passwd
echo "$(awk 'FNR==NR{ if (/auth/) p=NR; next} 1; FNR==p{ print "auth	optional	pam_gnome_keyring.so" }' /etc/pam.d/login /etc/pam.d/login)" > /etc/pam.d/login
echo "session	optional	pam_gnome_keyring.so auto_start" >> /etc/pam.d/login

# systemd services
systemctl enable bluetooth
systemctl enable tlp
fc-cache

