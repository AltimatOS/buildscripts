#!/bin/bash

set -e
set -u
set -o pipefail
set -x

NAME=inetutils
VERSION=2.5
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack gcc
tar xvf $SOURCE0

pushd $SRC_DIR
    sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c
    ./configure --prefix=/System            \
                --sysconfdir=/System/cfg    \
                --bindir=/System/bin        \
                --libdir=/System/lib64      \
                --localstatedir=/System/var \
                --disable-logger            \
                --disable-whois             \
                --disable-rcp               \
                --disable-rexec             \
                --disable-rlogin            \
                --disable-rsh               \
                --disable-servers
    make
    make check
    make install
    mv -v /System/{,s}bin/ifconfig
popd

# clean up
rm -rf $SRC_DIR
