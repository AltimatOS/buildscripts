#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=binutils
VERSION=2.42
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

# get binutils first
if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O "https://ftp.gnu.org/gnu/binutils/$SOURCE0"
fi

# unpack it
tar xvf "$SOURCE0"

# prep
pushd $SRC_DIR
    mkdir -v build
    pushd build
        ../configure --prefix=$LFS/tools \
                     --with-sysroot=$LFS \
                     --target=$LFS_TGT \
                     --disable-nls \
                     --enable-gprofng=no \
                     --disable-werror \
                     --enable-default-hash-style=gnu \
                     --enable-multilib
        make
        sudo make install
    popd
popd

# clean up
rm -rf $SRC_DIR
