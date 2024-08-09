#!/bin/bash

set -e
set -u
set -o pipefail
set -x

sudo mkdir -pv $LFS/{dev,proc,sys,System/var/run}

sudo mount -v --bind /dev $LFS/dev

sudo mount -v --bind /dev/pts $LFS/dev/pts
sudo mount -v --bind /proc $LFS/proc
sudo mount -v --bind /sys $LFS/sys
sudo mount -vt tmpfs tmpfs $LFS/System/var/run

if [[ -h $LFS/dev/shm ]]; then
    sudo install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
    sudo mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi

# mount our build scripts directory into the chroot
sudo mount -v --bind $HOME/buildscripts $LFS/System/var/root/buildscripts
