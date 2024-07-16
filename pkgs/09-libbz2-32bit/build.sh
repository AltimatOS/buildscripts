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

NAME=bzip2
VERSION=1.0.8
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch
    sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
    sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
    sed -e "s/^CC=.*/CC=gcc -m32/" -i Makefile{,-libbz2_so}

    make -f Makefile-libbz2_so
    make libbz2.a

    install -Dm755 libbz2.so.1.0.8 /System/lib/libbz2.so.1.0.8
    ln -sf libbz2.so.1.0.8 /System/lib/libbz2.so
    ln -sf libbz2.so.1.0.8 /System/lib/libbz2.so.1
    ln -sf libbz2.so.1.0.8 /System/lib/libbz2.so.1.0
    install -Dm644 libbz2.a /System/lib/libbz2.a
popd

# clean up
rm -rf $SRC_DIR
