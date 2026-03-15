#!/bin/sh
DEV=/dev/sdd
MNT=/mnt/btrfs

[ -b "$DEV" ] || exit 0

mkdir -p "$MNT"
mountpoint -q "$MNT" || mount -o subvol=@data,compress=zstd,noatime "$DEV" "$MNT"

# sudo chmod 755 /usr/local/sbin/mount-btrfs-root.sh
# 2. Allow passwordless sudo for this script only
# sudo visudo

# Add one line at the bottom:

# sibikrish ALL=(root) NOPASSWD: /usr/local/sbin/mount-btrfs-root.sh
#
# ~/.zshrc:

# Auto-mount Btrfs disk if present
# sudo /usr/local/sbin/mount-btrfs-root.sh >/dev/null 2>&1
