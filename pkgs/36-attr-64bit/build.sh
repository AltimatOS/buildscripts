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
    ./configure --prefix=/System                      \
                --libdir=/System/lib64                \
                --sysconfdir=/System/cfg              \
                --docdir=/System/share/doc/attr-2.5.2
    make
    make check
    make install
popd

compress_manpages 1
compress_manpages 3

# clean up
rm -rf $SRC_DIR
