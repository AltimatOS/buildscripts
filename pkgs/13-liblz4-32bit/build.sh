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

NAME=lz4
VERSION=1.9.4
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    CC="gcc -m32" make
    make PREFIX=/System LIBDIR=/System/lib DESTDIR=$(pwd)/m32 install &&
    cp -a m32/System/lib/* /System/lib/
popd

# clean up
rm -rf $SRC_DIR
