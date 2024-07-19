#!/bin/bash

set -e
set -u
set -o pipefail
set -x

function compress_manpages {
    local section=${1}
    for FILE in $(find /System/share/man/man${section} -type f -name "*.${section}"); do
        echo "Compressing file: $FILE"
        gzip -f -9 $FILE
    done
}

NAME=readline
VERSION=8.2
SOURCE0="${NAME}-${VERSION}.tar.gz"
PATCH0="readline-8.2-upstream_fixes-3.patch"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    sed -i '/MV.*old/d' Makefile.in
    sed -i '/{OLDSUFF}/c:' support/shlib-install
    sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf

    patch -Np1 -i ../$PATCH0

    CC="gcc -m32" \
    ./configure \
        --host=i686-pc-linux-gnu      \
        --prefix=/System              \
        --libdir=/System/lib          \
        --with-curses
    make SHLIB_LIBS="-lncursesw"
    make SHLIB_LIBS="-lncursesw" DESTDIR=$PWD/DESTDIR install
    cp -Rv DESTDIR/System/lib/* /System/lib
    rm -rf DESTDIR
popd

# clean up
rm -rf $SRC_DIR
