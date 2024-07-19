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

NAME=flex
VERSION=2.6.4
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                      \
                --libdir=/System/lib64                \
                --docdir=/System/share/doc/flex-2.6.4
    make
    make check
    make install

    pushd /System/bin
        if [[ ! -L lex ]]; then
            ln -s -v flex /System/bin/lex
            ln -s -v flex.1.gz /System/share/man/man1/lex.1
        fi
    popd
popd

compress_manpages 1

# clean up
rm -rf $SRC_DIR
