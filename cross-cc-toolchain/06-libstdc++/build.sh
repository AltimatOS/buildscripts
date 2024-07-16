#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=gcc
VERSION=14.1.0
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/$SOURCE0
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    mkdir -v build
    pushd build
        ../libstdc++-v3/configure --host=${LFS_TGT} \
                                  --build=$(../config.guess) \
                                  --prefix=/System \
                                  --enable-multilib \
                                  --disable-nls \
                                  --disable-libstdcxx-pch \
                                  --with-gxx-include-dir=/tools/${LFS_TGT}/include/c++/${VERSION}
        make
        sudo PATH=$PATH make DESTDIR=$LFS install

        sudo rm -v $LFS/System/lib/lib{stdc++{,exp,fs},supc++}.la
    popd
popd

# clean up
rm -rf $SRC_DIR
