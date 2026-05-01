#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/meowfeet/dotfiles.git /tmp/nixos
git -C /tmp/nixos remote set-url origin git@github.com:meowfeet/dotfiles.git
rm -f /tmp/nixos/hardware-configuration.nix

if [[ "$1" == /dev/nvme* ]]; then
  boot="${1}p1"
  crypt="${1}p2"
else
  boot="${1}1"
  crypt="${1}2"
fi

parted -s "$1" mklabel gpt
parted -s "$1" mkpart ESP fat32 1MiB 2GiB
parted -s "$1" set 1 esp on
parted -s "$1" mkpart crypt 2GiB 100%
partprobe "$1"
udevadm settle

mkfs.vfat -F 32 "$boot"
cryptsetup luksFormat -q "$crypt"
cryptsetup open --allow-discards "$crypt" crypted
mkfs.btrfs -f /dev/mapper/crypted

mount /dev/mapper/crypted /mnt
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@persist
umount /mnt

mount -t tmpfs -o mode=755 tmpfs /mnt
mkdir -p /mnt/boot /mnt/nix /mnt/persist
mount -o umask=0077 "$boot" /mnt/boot
mount -o compress=zstd,noatime,subvol=@nix /dev/mapper/crypted /mnt/nix
mount -o compress=zstd,noatime,subvol=@persist /dev/mapper/crypted /mnt/persist

mkdir -p /mnt/persist/etc /mnt/etc
mv /tmp/nixos /mnt/persist/etc/nixos
ln -s ../persist/etc/nixos /mnt/etc/nixos

mkdir -p /mnt/persist/.permissions
touch /mnt/persist/.permissions/save

nix-channel --add https://channels.nixos.org/nixos-unstable nixos
nix-channel --update

nixos-generate-config --root /mnt

hardware=/mnt/etc/nixos/hardware-configuration.nix
version="$(nix-instantiate --eval --raw '<nixpkgs/nixos>' -A config.system.nixos.release)"

sed -i \
  -e '/fsType = "tmpfs";/a options = [ "mode=755" ];' \
  -e 's/options = \[ "subvol=@nix" \];/options = [ "compress=zstd" "noatime" "subvol=@nix" ];/' \
  -e 's/options = \[ "subvol=@persist" \];/options = [ "compress=zstd" "noatime" "subvol=@persist" ];/' \
  -e '/subvol=@persist/a neededForBoot = true;' \
  -e '/boot.initrd.luks.devices\."crypted"\.device/a boot.initrd.luks.devices."crypted".allowDiscards = true;' \
  -e "/^}/i system.stateVersion = \"$version\";" \
  "$hardware"

nix-shell -p nixfmt --run "nixfmt $hardware"
nixos-install --root /mnt --no-root-passwd

name="$(nix-instantiate --eval --raw /mnt/etc/nixos/profile/settings.nix -A name)"
chown -R --reference="/mnt/home/$name" /mnt/persist/etc/nixos
