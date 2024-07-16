#!/bin/bash

set -e
set -u
set -o pipefail
set -x

echo "WARNING! This package must be build from WITHIN the chroot!"
sleep 5


NAME=inetutils
VERSION=2.5
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(cwd)" != "/srcs" ]]; then
    cd /srcs
fi

# unpack
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
                --disable-servers           \
                --disable-clients           \
                --enable-hostname           \
                --enable-dnsdomainname
    make
    make check
    make install
popd

# clean up
rm -rf $SRC_DIR
