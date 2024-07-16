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
    make HAVE_ZLIB=1 prefix=/System libdir=/System/lib64 -C lib lib-mt
    for DIRECTORY in programs contrib/pzstd; do
        make -C $DIRECTORY
    done
    make -C tests test-zstd
    make V=1 VERBOSE=1 prefix=/System libdir=/System/lib64 install
    install -D -m755 contrib/pzstd/pzstd /System/bin/pzstd
    install -D -m644 programs/zstd.1 /System/share/man/man1/pzstd.1
popd

compress_manpages 1

pushd /System/share/man/man1
    repoint_links unzstd.1 zstd.1.gz
    repoint_links zstdcat.1 zstd.1.gz
popd

# clean up
rm -rf $SRC_DIR
