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

NAME=zstd
VERSION=1.5.6
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    CC="gcc -m32" make HAVE_ZLIB=1 prefix=/System libdir=/System/lib -C lib lib-mt
    make prefix=/System libdir=/System/lib DESTDIR=$PWD/DESTDIR install
    cp -Rv DESTDIR/System/lib/* /System/lib/
    rm -rf DESTDIR
popd

# clean up
rm -rf $SRC_DIR
