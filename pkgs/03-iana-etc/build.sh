#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=iana-etc
VERSION=20240612
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack gcc
tar xvf $SOURCE0

pushd $SRC_DIR
    install -m 644 -o root -g root services /System/cfg/
    install -m 644 -o root -g root protocols /System/cfg/
popd

# clean up
rm -rf $SRC_DIR
