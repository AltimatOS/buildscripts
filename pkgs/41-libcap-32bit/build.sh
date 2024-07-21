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

NAME=libcap
VERSION=2.70
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    make CC="gcc -m32 -march=i686" prefix=/System lib=lib
    make CC="gcc -m32 -march=i686" lib=lib prefix=$PWD/DESTDIR/System -C libcap install
    cp -Rv DESTDIR/System/lib/* /System/lib
    sed -e "s|^libdir=.*|libdir=/System/lib|" -i /System/lib/pkgconfig/lib{cap,psx}.pc
    chmod -v 755 /System/lib/libcap.so.2.70
    rm -rf DESTDIR
popd

# clean up
rm -rf $SRC_DIR
