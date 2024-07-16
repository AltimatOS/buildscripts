#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=
VERSION=
SOURCE0="${NAME}-${VERSION}.tar."
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "$LFS/srcs" ]]; then
    cd $LFS/srcs
fi

# get the packages needed
if [[ ! -f $LFS/srcs/$SOURCE0 ]]; then
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
popd

# clean up
rm -rf $SRC_DIR
