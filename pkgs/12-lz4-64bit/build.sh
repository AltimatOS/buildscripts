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

function repoint_links {
    local lnk=${1}
    local tgt=${2}
    rm -f -v $lnk
    ln -s -f -v $tgt $lnk
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
    make
    make -j1 check
    make PREFIX=/System LIBDIR=/System/lib64 install
popd

compress_manpages 1

pushd /System/share/man
    for DIRECTORY in man1; do
        repoint_links lz4c.1 lz4.1.gz
        repoint_links lz4cat.1 lz4.1.gz
        repoint_links unlz4.1 lz4.1.gz
    done
popd

# clean up
rm -rf $SRC_DIR
