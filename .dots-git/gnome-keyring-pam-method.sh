#! /bin/sh
echo "password	optional	pam_gnome_keyring.so" >> /etc/pam.d/passwd
# sed -i "/system-local-login/ auth	optional	pam_gnome_keyring.so" /etc/pam.d/login

echo "$(awk 'FNR==NR{ if (/auth/) p=NR; next} 1; FNR==p{ print "auth	optional	pam_gnome_keyring.so" }' /etc/pam.d/login /etc/pam.d/login)" > /etc/pam.d/login

# awk 'FNR==NR{ if (/auth/) p=NR; next} 1; FNR==p{ print "auth	optional	pam_gnome_keyring.so" }' /etc/pam.d/login /etc/pam.d/login

echo "session	optional	pam_gnome_keyring.so auto_start" >> /etc/pam.d/login

