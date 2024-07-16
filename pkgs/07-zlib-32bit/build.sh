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

NAME=zlib
VERSION=1.3.1
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    CFLAGS+=" -m32" CXXFLAGS+=" -m32" \
    ./configure --prefix=/System      \
                --libdir=/System/lib
    make
    make DESTDIR=$PWD/DESTDIR install
    cp -Rv DESTDIR/System/lib/* /System/lib
    rm -rf DESTDIR
popd

# clean up
rm -rf $SRC_DIR
