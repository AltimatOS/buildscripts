#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=file
VERSION=5.45
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://astron.com/pub/file/$SOURCE0
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    mkdir -pv build
    pushd build
        ../configure --disable-bzlib --disable-libseccomp --disable-xzlib --disable-zlib
        make
    popd

    ./configure --prefix=/System --libdir=/System/lib64 --host=$LFS_TGT --build=$(./config.guess)
    PATH=$PATH make FILE_COMPILE=$(pwd)/build/src/file
    sudo PATH=$PATH make DESTDIR=$LFS install
    sudo rm -v $LFS/System/lib64/libmagic.la
popd

# clean up
rm -rf $SRC_DIR
