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
# gcc
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://ftp.gnu.org/gnu/gcc/gcc-$VERSION/$SOURCE0
fi
if [[ ! -f $LFS/srcs/$SOURCE1 ]]; then
    curl -O https://ftp.gnu.org/gnu/gmp/$SOURCE1
fi
if [[ ! -f $LFS/srcs/$SOURCE2 ]]; then
    curl -O https://ftp.gnu.org/gnu/mpc/$SOURCE2
fi
if [[ ! -f $LFS/srcs/$SOURCE3 ]]; then
    curl -O https://ftp.gnu.org/gnu/mpfr/$SOURCE3
fi

# now unpack gcc
tar xvf $SOURCE0

pushd $SRC_DIR
    tar xvf ../$SOURCE1
    mv -v gmp-6.3.0 gmp
    tar xvf ../$SOURCE2
    mv -v mpc-1.3.1 mpc
    tar xvf ../$SOURCE3
    mv -v mpfr-4.2.1 mpfr

    mkdir -v build
    pushd build
        # now configure the package
        mlist=m64,m32
        ../configure  --target=$LFS_TGT --prefix=$LFS/tools --with-glibc-version=2.39 --with-sysroot=$LFS --with-newlib --without-headers \
                      --enable-default-pie --enable-default-ssp --enable-initfini-array --disable-nls --disable-shared --enable-multilib --with-multilib-list=$mlist \
                      --disable-decimal-float --disable-threads --disable-libatomic --disable-libgomp --disable-libquadmath --disable-libssp --disable-libvtv \
                      --disable-libstdcxx --enable-languages=c,c++
        make
        sudo make install
    popd

    # fix up for the limits.h header
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
      $(dirname $($LFS_TGT-gcc -print-libgcc-file-name))/include/limits.h
popd

# clean up
rm -rf $SRC_DIR
