#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=linux-headers
VERSION=6.9.8
SOURCE0="linux-${VERSION}.tar.xz"
SRC_DIR="linux-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O "https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/$SOURCE0"
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    # ensure clean tree
    make mrproper

    # make headers
    make headers
    find usr/include/ -type f ! -name "*.h" -delete
    sudo cp -r -v usr/include $LFS/System
popd

# clean up
rm -rf $SRC_DIR
