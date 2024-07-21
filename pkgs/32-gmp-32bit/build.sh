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
    cp -v configfsf.guess config.guess
    cp -v configfsf.sub   config.sub

    ABI="32"                                                                    \
    CFLAGS="-m32 -O2 -pedantic -fomit-frame-pointer -mtune=generic -march=i686" \
    CXXFLAGS="$CFLAGS"                                                          \
    PKG_CONFIG_PATH="/System/lib/pkgconfig"                                     \
    ./configure                                                                 \
        --host=i686-pc-linux-gnu                                                \
        --prefix=/System                                                        \
        --enable-cxx                                                            \
        --libdir=/System/lib
    make
    make check 2>&1 | tee gmp-check-log
    awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log

    make DESTDIR=$PWD/DESTDIR install
    cp -Rv DESTDIR/System/lib/* /System/lib
    rm -rf DESTDIR
popd

# clean up
rm -rf $SRC_DIR
