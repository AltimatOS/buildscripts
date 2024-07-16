#!/bin/bash

set -e
set -u
set -o pipefail
set -x

echo "WARNING! This package must be build from WITHIN the chroot!"
sleep 5

NAME=texinfo
VERSION=7.1
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(cwd)" != "/srcs" ]]; then
    cd /srcs
fi

tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System
    make
    make install
popd

# clean up
rm -rf $SRC_DIR
