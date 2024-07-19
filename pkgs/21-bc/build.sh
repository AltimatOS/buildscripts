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

NAME=bc
VERSION=6.7.6
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    CC=gcc \
    ./configure --prefix=/System       \
                --libdir=/System/lib64 \
                -G -O3 -r
    make
    make test
    make install
popd

compress_manpages 1

# clean up
rm -rf $SRC_DIR
