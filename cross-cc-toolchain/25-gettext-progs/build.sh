#!/bin/bash

set -e
set -u
set -o pipefail
set -x

echo "WARNING! This package must be build from WITHIN the chroot!"
sleep 5

NAME=gettext
VERSION=0.22.5
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# no curl yet, so cannot pull from network
# unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --disable-shared
    make

    # only need progs for now
    cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /System/bin
popd

# clean up
rm -rf $SRC_DIR
