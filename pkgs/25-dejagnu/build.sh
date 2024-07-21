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

NAME=dejagnu
VERSION=1.6.3
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    mkdir -v build
    pushd build
        ../configure                \
             --prefix=/System       \
             --libdir=/System/lib64
        makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
        makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi
        make check
        make install
        install -v -d -m 755 "/System/share/doc/${NAME}-${VERSION}"
        install -v -m 644     doc/dejagnu.{html,txt} "/System/share/doc/${NAME}-${VERSION}"
    popd
popd

compress_manpages 1

# clean up
rm -rf $SRC_DIR
