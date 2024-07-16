#!/bin/bash

set -e
set -u
set -o pipefail
set -x

function compress_manpages {
    local section=${1}
    for FILE in $(find /System/share/man/man${section} -type f -name "*.${section}"); do
        echo "Compressing file: $FILE"
        gzip -9 $FILE
    done
}

NAME=glibc
VERSION=2.39
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    patch -N -p 1 -i ../${NAME}-${VERSION}-fhs-1.patch
    patch -N -p 1 -i ../${NAME}-${VERSION}-upstream_fix-2.patch

    mkdir -pv build
    pushd build
        echo "rootsbindir=/System/sbin" > configparms

        CC="gcc -m32" CXX="g++ -m32" \
        ../configure                             \
              --prefix=/System                   \
              --sysconfdir=/System/cfg           \
              --host=i686-pc-linux-gnu           \
              --build=$(../scripts/config.guess) \
              --enable-kernel=6.4                \
              --libdir=/System/lib               \
              --libexecdir=/System/lib           \
              libc_cv_slibdir=/System/lib

        make
        make DESTDIR=$PWD/DESTDIR install
        cp -a DESTDIR/System/lib/* /System/lib/
        install -vm644 DESTDIR/System/include/gnu/{lib-names,stubs}-32.h \
               /System/include/gnu/
    popd
popd

# clean up
rm -rf $SRC_DIR
