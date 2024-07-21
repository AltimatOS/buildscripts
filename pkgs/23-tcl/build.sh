#!/bin/bash

set -e
set -u
set -o pipefail
set -x

function compress_manpages {
    local section=${1}
    for FILE in $(find /System/share/man/man${section} -type f -name "*.${section}"); do
        echo "Compressing file: $FILE"
        gzip -f -9 $FILE
    done
}

NAME=tcl
VERSION=8.6.14
SOURCE0="${NAME}${VERSION}-src.tar.gz"
SOURCE1="${NAME}${VERSION}-html.tar.gz"
SRC_DIR="${NAME}${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    SRCDIR="$(pwd)"
    cd unix
    ./configure --prefix=/System           \
                --libdir=/System/lib64     \
                --mandir=/System/share/man \
                --disable-rpath
    make

    sed -e "s|$SRCDIR/unix|/System/lib64|" \
        -e "s|$SRCDIR|/System/include|"    \
        -i tclConfig.sh

    sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.7|/System/lib64/tdbc1.1.7|" \
        -e "s|$SRCDIR/pkgs/tdbc1.1.7/generic|/System/include|"      \
        -e "s|$SRCDIR/pkgs/tdbc1.1.7/library|/System/lib64/tcl8.6|" \
        -e "s|$SRCDIR/pkgs/tdbc1.1.7|/System/include|"              \
        -i pkgs/tdbc1.1.7/tdbcConfig.sh

    sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.4|/System/lib64/itcl4.2.4|" \
        -e "s|$SRCDIR/pkgs/itcl4.2.4/generic|/System/include|"      \
        -e "s|$SRCDIR/pkgs/itcl4.2.4|/System/include|"              \
        -i pkgs/itcl4.2.4/itclConfig.sh

    unset SRCDIR

    make test
    make install

    chmod -v u+w /System/lib64/libtcl8.6.so

    make install-private-headers
    if [[ ! -L /System/bin/tclsh ]]; then
        ln -s -v tclsh8.6 /System/bin/tclsh
    fi
    mv /System/share/man/man3/{Thread,Tcl_Thread}.3

    mkdir -p -v "/srcs/$SRC_DIR/html_docs"
    pushd "/srcs/$SRC_DIR/html_docs"
        tar -xvf "/srcs/$SOURCE1" -C "/srcs/$SRC_DIR/html_docs/" --strip-components=1
        install -v -d -m 755 -o root -g root "/System/share/doc/${NAME}-${VERSION}"
        cp -v -r  ./html/* "/System/share/doc/${NAME}-${VERSION}"
    popd
popd

compress_manpages 1
compress_manpages 3
compress_manpages n

# clean up
rm -rf $SRC_DIR
