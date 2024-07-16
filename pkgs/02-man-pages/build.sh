#!/bin/bash

set -e
set -u
set -o pipefail
set -x

function compress_manpages {
    local section=${1}
    for FILE in $(find /System/share/man/man${section} -type f -name "*.${section}"); do
        echo "Compressing file: $FILE"
        gzip -9 $FILE
    done
}

NAME=man-pages
VERSION=6.9.1
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack gcc
tar xvf $SOURCE0

pushd $SRC_DIR
    rm -v man3/crypt*
    make prefix=/System install
popd

compress_manpages 1
compress_manpages 2
compress_manpages 2const
compress_manpages 2type
compress_manpages 3
compress_manpages 3const
compress_manpages 3head
compress_manpages 3type
compress_manpages 4
compress_manpages 5
compress_manpages 6
compress_manpages 7
compress_manpages 8

# clean up
rm -rf $SRC_DIR
