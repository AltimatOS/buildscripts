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

NAME=mpc
VERSION=1.3.1
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                     \
                --libdir=/System/lib64               \
                --docdir=/System/share/doc/mpc-1.3.1
    make
    make html

    make check

    make install
    make install-html
popd

# clean up
rm -rf $SRC_DIR
