#!/bin/bash

set -e
set -u
set -o pipefail
set -x

echo "WARNING! This package must be build from WITHIN the chroot!"
sleep 5

NAME=perl
VERSION=5.40.0
SOURCE0="${NAME}-${VERSION}.tar.gz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(cwd)" != "/srcs" ]]; then
    cd /srcs
fi

# unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    sh Configure -des                                                                         \
                 -D prefix=/System                                                            \
                 -D vendorprefix=/System                                                      \
                 -D installusrbinperl                                                         \
                 -D useshrplib                                                                \
                 -D use64bitint                                                               \
                 -D use64bitall                                                               \
                 -D uselongdouble                                                             \
                 -D usethreads                                                                \
                 -D uselargefiles                                                             \
                 -D privlib=/System/lib/perl5/5.40.0                                          \
                 -D archlib=/System/lib/perl5/5.40.0/x86_64-linux-thread-multi                \
                 -D sitelib=/System/lib/perl5/site_perl/5.40.0                                \
                 -D sitearch=/System/lib/perl5/site_perl/5.40.0/x86_64-linux-thread-multi     \
                 -D vendorlib=/System/lib/perl5/vendor_perl/5.40.0                            \
                 -D vendorarch=/System/lib/perl5/vendor_perl/5.40.0/x86_64-linux-thread-multi
    make
    make install
popd

# clean up
rm -rf $SRC_DIR
