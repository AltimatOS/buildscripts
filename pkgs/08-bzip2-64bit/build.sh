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

    make -f Makefile-libbz2_so
    make clean
    make
    make PREFIX=/System install

    cp -av libbz2.so.* /System/lib64
    ln -sfv libbz2.so.1.0.8 /System/lib64/libbz2.so

    cp -v bzip2-shared /System/bin/bzip2
    for i in /System/bin/{bzcat,bunzip2}; do
        ln -sfv bzip2 $i
    done
popd

compress_manpages 1

# clean up
rm -rf $SRC_DIR
