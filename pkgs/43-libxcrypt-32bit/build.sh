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

NAME=libxcrypt
VERSION=4.4.36
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    CC="gcc -m32" \
    ./configure --prefix=/System             \
                --host=i686-pc-linux-gnu     \
                --libdir=/System/lib         \
                --enable-hashes=strong,glibc \
                --enable-obsolete-api=glibc  \
                --disable-failure-tokens
    make
    cp -av .libs/libcrypt.so* /System/lib/ &&
    make install-pkgconfigDATA &&
    ln -svf libxcrypt.pc /System/lib/pkgconfig/libcrypt.pc
popd

# clean up
rm -rf $SRC_DIR
