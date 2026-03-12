#!/usr/bin/env bash
set -e

WINDOWS_BOOTNUM="0000"

sudo efibootmgr -n "$WINDOWS_BOOTNUM"
systemctl reboot
