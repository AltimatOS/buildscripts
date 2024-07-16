#!/bin/bash

set -e
set -u
set -o pipefail
set -x

echo "WARNING! This package must be build from WITHIN the chroot!"
sleep 5

NAME=bison
VERSION=3.8.2
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(cwd)" != "/srcs" ]]; then
    cd /srcs
fi

# unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                     \
                --libdir=/System/lib64               \
                --docdir=/System/share/doc/bison-3.8.2

    make
    make install
popd

# clean up
rm -rf $SRC_DIR
