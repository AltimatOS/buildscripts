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

NAME=expect
VERSION=5.45.4
SOURCE0="${NAME}${VERSION}.tar.gz"
SRC_DIR="${NAME}${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    patch -Np1 -i ../expect-5.45.4-gcc14-1.patch
    ./configure --prefix=/System                  \
                --libdir=/System/lib64            \
                --with-tcl=/System/lib64          \
                --enable-shared                   \
                --disable-rpath                   \
                --mandir=/System/share/man        \
                --with-tclinclude=/System/include
    make
    make test
    make install
    ln -svf expect5.45.4/libexpect5.45.4.so /System/lib64
popd

compress_manpages 1
compress_manpages 3

# clean up
rm -rf $SRC_DIR
