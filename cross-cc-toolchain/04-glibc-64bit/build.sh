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
    # first add a couple compatibility links for the build
    sudo ln -sfv ld-linux-x86-64.so.2 "$LFS/lib64/ld-lsb-x86-64.so.2"
    sudo ln -sfv ld-linux-x86-64.so.2 "$LFS/lib64/ld-lsb-x86-64.so.3"

    # patch to fix glibc's use of /var/db. This requires the OS compatibility links for now
    patch -N -p1 -i ../${NAME}-${VERSION}-fhs-1.patch

    # create build directory
    mkdir -p -v build
    pushd build
        echo "rootsbindir=/System/sbin" > configparms
        # configure it
        CC="$LFS_TGT-gcc -m64" CXX="$LFS_TGT-g++ -m64" \
        ../configure --prefix=/System --host=$LFS_TGT --build=$(../scripts/config.guess) --enable-kernel=6.4 \
                 --with-headers=$LFS/System/include --enable-multi-arch --libdir=/System/lib64 --libexecdir=/System/lib64 \
                 libc_cv_slibdir=/System/lib64

        # build it
        make

        # and install
        sudo PATH=$PATH make DESTDIR=$LFS install

        # small fix up for the ld script
        sudo sed '/RTLDLIST=/s@/System@@g' -i $LFS/System/bin/ldd
    popd
popd

# clean up
sudo rm -rf $SRC_DIR
