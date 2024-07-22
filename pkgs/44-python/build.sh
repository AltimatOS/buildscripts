#!/bin/bash

set -e
set -u
set -o pipefail
set -x

function compress_manpages {
    local section=${1}
    for FILE in $(find /System/share/man/man${section} -type f -name "*.${section}"); do
        echo "Compressing file: $FILE"
        gzip -9 $FILE
    done
}

NAME=python
VERSION=3.12.4
PKG_NAME=Python
SOURCE0="${PKG_NAME}-${VERSION}.tar.xz"
SRC_DIR="${PKG_NAME}-${VERSION}"

if [[ "$(cwd)" != "/srcs" ]]; then
    cd /srcs
fi

tar xvf $SOURCE0

pushd $SRC_DIR
    ./configure --prefix=/System         \
                --sysconfdir=/System/cfg \
                --libdir=/System/lib64   \
                --with-platlibdir=lib    \
                --enable-shared          \
                --enable-zlib            \
                --enable-optimizations
    make
    make test TESTOPTS="--timeout 120" ||:
    make install

    if [[ ! -f /System/cfg/pip.conf ]]; then
        cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF
    fi
popd

compress_manpages 1

# correct symlink's target
pushd /System/share/man/man1
    rm -fv python3.1
    ln -sfv python3.12.1.gz python3.1
popd

# clean up
rm -rf $SRC_DIR
