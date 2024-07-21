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
    ./configure --prefix=/System             \
                --libdir=/System/lib64       \
                --enable-hashes=strong,glibc \
                --enable-obsolete-api=glibc  \
                --disable-failure-tokens
    make
    make check
    make install
popd

compress_manpages 3
compress_manpages 5

# clean up
rm -rf $SRC_DIR
