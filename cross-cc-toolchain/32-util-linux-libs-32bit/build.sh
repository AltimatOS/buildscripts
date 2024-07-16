#!/bin/bash

set -e
set -u
set -o pipefail
set -x

echo "WARNING! This package must be build from WITHIN the chroot!"
sleep 5

NAME=util-linux
VERSION=2.40.2
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(cwd)" != "/srcs" ]]; then
    cd /srcs
fi

tar xvf $SOURCE0

pushd $SRC_DIR
    CC="gcc -m32" \
    ./configure --host=i686-pc-linux-gnu                     \
                --prefix=/System                             \
                --libdir=/System/lib                         \
                --runstatedir=/System/var/run                \
                --docdir=/System/share/doc/util-linux-2.40.1 \
                --disable-chfn-chsh                          \
                --disable-login                              \
                --disable-nologin                            \
                --disable-su                                 \
                --disable-setpriv                            \
                --disable-runuser                            \
                --disable-pylibmount                         \
                --disable-static                             \
                --disable-liblastlog2                        \
                --without-python                             \
                ADJTIME_PATH=/System/var/lib/hwclock/adjtime
    make
    make DESTDIR=$PWD/DESTDIR install
    cp -Rv DESTDIR/System/lib/* /System/lib
popd

# clean up
rm -rf $SRC_DIR
