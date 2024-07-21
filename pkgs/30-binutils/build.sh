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

NAME=binutils
VERSION=2.42
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    mkdir -v build
    cd       build

    ../configure --prefix=/System                \
                 --sysconfdir=/Systen/cfg        \
                 --enable-gold                   \
                 --enable-ld=default             \
                 --enable-plugins                \
                 --enable-shared                 \
                 --disable-werror                \
                 --enable-64-bit-bfd             \
                 --with-system-zlib              \
                 --enable-default-hash-style=gnu \
                 --enable-multilib
    make tooldir=/System
    make -k check ||:
    make tooldir=/System install
popd

compress_manpages 1

# clean up
rm -rf $SRC_DIR
