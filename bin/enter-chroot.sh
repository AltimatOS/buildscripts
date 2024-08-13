#!/bin/bash

set -e
set -u
set -o pipefail
set -x

sudo chroot "$LFS" /System/bin/env -i                                                \
    HOME=/System/var/root                                                            \
    TERM="$TERM"                                                                     \
    PS1='(lfs chroot) \u:\w> $ '                                                     \
    PATH=/System/bin:/System/sbin:/System/var/root/buildscripts/3rd-party-static-bin \
    MAKEFLAGS="-j4"                                                                  \
    TESTSUITEFLAGS="-j4"                                                             \
    /System/bin/bash --login --rcfile /System/var/root/.bashrc

