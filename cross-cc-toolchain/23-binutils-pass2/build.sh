#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=binutils
VERSION=2.42
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O "https://ftp.gnu.org/gnu/binutils/$SOURCE0"
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    sed '6009s/$add_dir//' -i ltmain.sh
    mkdir -v build
    pushd build
        ../configure                        \
            --prefix=/System                \
            --build=$(../config.guess)      \
            --host=$LFS_TGT                 \
            --disable-nls                   \
            --enable-shared                 \
            --enable-gprofng=no             \
            --disable-werror                \
            --enable-64-bit-bfd             \
            --enable-default-hash-style=gnu \
            --enable-multilib
        make
        sudo PATH=$PATH make DESTDIR=$LFS install
        rm -vf $LFS/System/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
    popd
popd

# clean up
rm -rf $SRC_DIR
