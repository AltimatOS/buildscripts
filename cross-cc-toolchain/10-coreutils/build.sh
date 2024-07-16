#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=coreutils
VERSION=9.5
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://ftp.gnu.org/gnu/coreutils/$SOURCE0
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                  \
                --host=$LFS_TGT                   \
                --build=$(build-aux/config.guess) \
                --enable-no-install-program=kill
    make
    sudo PATH=$PATH make DESTDIR=$LFS install

    # small fixes
    sudo mv -v $LFS/System/bin/chroot              $LFS/System/sbin
    sudo mkdir -pv $LFS/System/share/man/man8
    sudo mv -v $LFS/System/share/man/man1/chroot.1 $LFS/System/share/man/man8/chroot.8
    sudo sed -i 's/"1"/"8"/'                       $LFS/System/share/man/man8/chroot.8
popd

# clean up
rm -rf $SRC_DIR
