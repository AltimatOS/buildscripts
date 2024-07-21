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

NAME=isl
VERSION=0.26
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                 \
                --libdir=/System/lib64           \
                --docdir=/usr/share/doc/isl-0.26
    make
    make install
    install -v -d -m755 /System/share/doc/isl-0.26
    install -v -m644    doc/{CodingStyle,manual.pdf,SubmittingPatches,user.pod} /System/share/doc/isl-0.26
    mkdir -pv /System/share/gdb/auto-load/System/lib64
    mv -v /System/lib64/libisl*gdb.py /System/share/gdb/auto-load/System/lib64
popd

# clean up
rm -rf $SRC_DIR
