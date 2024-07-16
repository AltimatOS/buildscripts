#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=xz
VERSION=5.6.2
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://github.com/tukaani-project/xz/releases/download/v${VERSION}/$SOURCE0
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                  \
                --libdir=/System/lib64            \
                --host=$LFS_TGT                   \
                --build=$(build-aux/config.guess) \
                --disable-static                  \
                --docdir=/usr/share/doc/xz-5.6.2
    make
    sudo PATH=$PATH make DESTDIR=$LFS install
    sudo rm -v $LFS/System/lib64/liblzma.la
popd

# clean up
rm -rf $SRC_DIR
