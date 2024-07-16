#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=gzip
VERSION=1.13
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O https://ftp.gnu.org/gnu/${NAME}/$SOURCE0
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/usr --host=$LFS_TGT --libdir=/System/lib64
    make
    sudo PATH=$PATH make DESTDIR=$LFS install
popd

# clean up
rm -rf $SRC_DIR
