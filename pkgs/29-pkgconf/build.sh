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

NAME=pkgconf
VERSION=2.2.0
SOURCE0="${NAME}-${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./autogen.sh
    ./configure --prefix=/System                         \
                --libdir=/System/lib64                   \
                --docdir=/System/share/doc/pkgconf-2.2.0
    make
    make install
    if [[ ! -L /System/bin/pkg-config ]]; then
        ln -sv pkgconf      /System/bin/pkg-config
        ln -sv pkgconf.1.gz /System/share/man/man1/pkg-config.1
    fi
popd

compress_manpages 1
compress_manpages 5
compress_manpages 7

# clean up
rm -rf $SRC_DIR
