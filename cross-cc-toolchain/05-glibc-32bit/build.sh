#!/bin/bash

set -e
set -u
set -o pipefail
set -x

PATH=/mnt/AltimatOS/tools/bin:/System/bin:/Users/builder/buildscripts:/bin:/usr/bin
export PATH

NAME=glibc
VERSION=2.39
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://ftp.gnu.org/gnu/glibc/$SOURCE0
fi

# now unpack
tar xvf $SOURCE0

pkg_root_dir=$(pwd)

pushd $SRC_DIR
    sudo ln -sv ld-linux.so.2 "$LFS/System/lib/ld-lsb.so.2"
    sudo ln -sv ld-linux.so.2 "$LFS/System/lib/ld-lsb.so.3"

    # patch to fix glibc's use of /var/db. This requires the OS compatibility links for now
    patch -N -p1 -i ../${NAME}-${VERSION}-fhs-1.patch

    # create build directory
    mkdir -p -v build
    pushd build
        CC="$LFS_TGT-gcc -m32" \
        CXX="$LFS_TGT-g++ -m32" \
        ../configure                         \
          --prefix=/System                   \
          --host=$LFS_TGT32                  \
          --build=$(../scripts/config.guess) \
          --enable-kernel=6.4                \
          --with-headers=$LFS/System/include \
          --disable-nscd                     \
          --libdir=/System/lib               \
          --libexecdir=/System/lib           \
          libc_cv_slibdir=/System/lib

        make
        make DESTDIR=$PWD/DESTDIR install
        sudo cp -a DESTDIR/System/lib $LFS/System/
        sudo install -vm644 DESTDIR/System/include/gnu/{lib-names,stubs}-32.h \
                            $LFS/System/include/gnu/
#        sudo ln -svf ../lib/ld-linux.so.2 $LFS/lib/ld-linux.so.2
    popd
popd

# clean up
sudo rm -rf $SRC_DIR
