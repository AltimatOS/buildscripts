#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=ncurses
VERSION=6.5
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://ftp.gnu.org/gnu/ncurses/$SOURCE0
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    # make configure find gawk
    sed -i s/mawk// configure

    # build tic
    mkdir build
    pushd build
        ../configure
        make -C include
        make -C progs tic
    popd

    # configure it
    ./configure --prefix=/System \
                --host=$LFS_TGT \
                --build=$(./config.guess) \
                --libdir=/System/lib64 \
                --mandir=/System/share/man \
                --with-manpage-format=normal \
                --with-shared \
                --without-normal \
                --with-cxx-shared \
                --without-debug \
                --without-ada \
                --disable-stripping \
                --enable-widec

    # build it
    make

    # install
    sudo PATH=$PATH make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
    sudo ln -svf libncursesw.so $LFS/System/lib64/libncurses.so
    sudo sed -e 's/^#if.*XOPEN.*$/#if 1/' -i $LFS/System/include/ncursesw/curses.h

    # Now, deal with 32bit
    make distclean

    CC="$LFS_TGT-gcc -m32" CXX="$LFS_TGT-g++ -m32" \
    ./configure --prefix=/System \
                --host=$LFS_TGT32 \
                --build=$(./config.guess) \
                --libdir=/System/lib \
                --mandir=/System/share/man \
                --with-shared \
                --without-normal \
                --with-cxx-shared \
                --without-debug \
                --without-ada \
                --disable-stripping \
                --enable-widec

    # build 32-bit
    make

    # install 32-bit
    PATH=$PATH make DESTDIR=$PWD/DESTDIR TIC_PATH=$(pwd)/build/progs/tic install
    ln -svf libncursesw.so DESTDIR/System/lib/libcurses.so
    sudo cp -Rv DESTDIR/System/lib/* $LFS/System/lib
popd

# clean up
rm -rf $SRC_DIR
