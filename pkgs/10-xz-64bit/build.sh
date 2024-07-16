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

function compress_manpages_translated {
    local section=${1}
    for FILE in $(find /System/share/man/*/man${section} -type f -name "*.${section}"); do
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

NAME=xz
VERSION=5.6.2
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                    \
                --libdir=/System/lib64              \
                --enable-shared                     \
                --enable-static                     \
                --docdir=/System/share/doc/xz-5.6.2
    make
    make check
    make install
popd

compress_manpages 1
compress_manpages_translated 1

pushd /System/share/man
    for DIRECTORY in man1 de/man1 fr/man1 ko/man1 pt_BR/man1 ro/man1 uk/man1; do
        pushd man1/
            repoint_links lzmadec.1 xzdec.1.gz
            repoint_links unxz.1 xz.1.gz
            repoint_links xzcat.1 xz.1.gz
            repoint_links lzma.1 xz.1.gz
            repoint_links unlzma.1 xz.1.gz
            repoint_links lzcat.1 xz.1.gz
            repoint_links xzcmp.1 xzdiff.1.gz
            repoint_links xzegrep.1 xzgrep.1.gz
            repoint_links xzfgrep.1 xzgrep.1.gz
            repoint_links lzdiff.1 xzdiff.1.gz
            repoint_links lzcmp.1 xzdiff.1.gz
            repoint_links lzgrep.1 xzgrep.1.gz
            repoint_links lzegrep.1 xzgrep.1.gz
            repoint_links lzfgrep.1 xzgrep.1.gz
            repoint_links lzmore.1 xzmore.1.gz
            repoint_links lzless.1 xzless.1.gz
        popd
    done
popd

# clean up
rm -rf $SRC_DIR
