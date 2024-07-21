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

NAME=attr
VERSION=2.5.2
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    CC="gcc -m32"                        \
    ./configure --prefix=/System         \
                --sysconfdir=/System/cfg \
                --libdir=/System/lib     \
                --host=i686-pc-linux-gnu
    make

    make DESTDIR=$PWD/DESTDIR install
    cp -Rv DESTDIR/System/lib/* /System/lib
    rm -rf DESTDIR
popd

# clean up
rm -rf $SRC_DIR
