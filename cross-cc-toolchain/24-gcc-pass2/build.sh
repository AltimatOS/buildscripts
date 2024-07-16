#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=gcc
VERSION=14.1.0
SOURCE0="${NAME}-${VERSION}.tar.xz"
SOURCE1="gmp-6.3.0.tar.xz"
SOURCE2="mpc-1.3.1.tar.gz"
SOURCE3="mpfr-4.2.1.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://ftp.gnu.org/gnu/${NAME}/${NAME}-${VERSION}/$SOURCE0
fi
if [[ ! -f $LFS/srcs/$SOURCE1 ]]; then
    curl -O https://ftp.gnu.org/gnu/gmp/$SOURCE1
fi
if [[ ! -f $LFS/srcs/$SOURCE2 ]]; then
    curl -O https://ftp.gnu.org/gnu/mpc//$SOURCE2
fi
if [[ ! -f $LFS/srcs/$SOURCE3 ]]; then
    curl -O https://ftp.gnu.org/gnu/mpfr/$SOURCE3
fi

# now unpack gcc
tar xvf $SOURCE0

pushd $SRC_DIR
    tar -xf ../$SOURCE1
    mv -v gmp-6.3.0 gmp
    tar -xf ../$SOURCE2
    mv -v mpc-1.3.1 mpc
    tar -xf ../$SOURCE3
    mv -v mpfr-4.2.1 mpfr

    sed '/thread_header =/s/@.*@/gthr-posix.h/' \
        -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

    mkdir -v build
    pushd build
        mlist=m64,m32
        ../configure                                   \
            --build=$(../config.guess)                 \
            --host=$LFS_TGT                            \
            --target=$LFS_TGT                          \
            LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc  \
            --prefix=/System                           \
            --with-build-sysroot=$LFS                  \
            --enable-default-pie                       \
            --enable-default-ssp                       \
            --disable-nls                              \
            --enable-multilib                          \
            --with-multilib-list=$mlist                \
            --disable-libatomic                        \
            --disable-libgomp                          \
            --disable-libquadmath                      \
            --disable-libsanitizer                     \
            --disable-libssp                           \
            --disable-libvtv                           \
            --enable-languages=c,c++
        make
        sudo PATH=$PATH make DESTDIR=$LFS install
        sudo ln -svf gcc $LFS/System/bin/cc
    popd
popd

# clean up
rm -rf $SRC_DIR
