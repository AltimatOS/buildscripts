#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=bash
VERSION=5.2.21
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
    curl -O "https://ftp.gnu.org/gnu/${NAME}/${SOURCE0}"
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System                   \
                --build=$(sh support/config.guess) \
                --host=$LFS_TGT                    \
                --without-bash-malloc              \
                --libdir=/System/lib64
    make
    sudo PATH=$PATH make DESTDIR=$LFS install

    # set bash as sh for now. Will move to zsh later
    sudo ln -svf bash $LFS/System/bin/sh
popd

# clean up
rm -rf $SRC_DIR
