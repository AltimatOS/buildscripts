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

NAME=gmp
VERSION=6.3.0
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                     \
                --libdir=/System/lib64               \
                --enable-cxx                         \
                --docdir=/System/share/doc/gmp-6.3.0
    make
    make html
    make check 2>&1 | tee gmp-check-log
    awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log

    make install
    make install-html
popd

# clean up
rm -rf $SRC_DIR
