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
        CC="${LFS_TGT}-gcc -m32" \
        ../configure --host=$LFS_TGT32 --disable-bzlib --disable-libseccomp --disable-xzlib --disable-zlib
        make -j1
    popd

    CC="${LFS_TGT}-gcc -m32" \
    ./configure --prefix=/System --libdir=/System/lib --host=$LFS_TGT32
    make -j1 FILE_COMPILE="file -m $LFS/System/share/misc/magic.mgc"
    sudo install -m 644 -o root -g root libmagic.pc $LFS/System/lib/pkgconfig/
    file -m $LFS/System/share/misc/magic.mgc src/.libs/libmagic.so.1.0.0
    sudo install -m 755 -o root -g root src/.libs/libmagic.so.1.0.0 $LFS/System/lib/
    sudo ln -svf libmagic.so.1.0.0 $LFS/System/lib/libmagic.so
    sudo ln -svf libmagic.so.1.0.0 $LFS/System/lib/libmagic.so.1
popd

# clean up
rm -rf $SRC_DIR
