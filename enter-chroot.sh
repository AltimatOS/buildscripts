#!/bin/bash

set -e
set -u
set -o pipefail
set -x

# mount our build scripts directory into the chroot
sudo mount -v --bind $HOME/buildscripts $LFS/System/var/root/buildscripts

sudo chroot "$LFS" /System/bin/env -i \
    HOME=/System/var/root             \
    TERM="$TERM"                      \
    PS1='(lfs chroot) \u:\w\$ '       \
    PATH=/System/bin:/System/sbin     \
    MAKEFLAGS="-j4"                   \
    TESTSUITEFLAGS="-j4"              \
    /System/bin/bash --login

