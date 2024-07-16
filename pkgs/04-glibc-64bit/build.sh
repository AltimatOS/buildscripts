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

NAME=glibc
VERSION=2.39
SOURCE0="${NAME}-${VERSION}.tar.xz"
SRC_DIR="${NAME}-${VERSION}"

if [[ "$(pwd)" != "/srcs" ]]; then
    cd /srcs
fi

# now unpack
tar xvf $SOURCE0

pushd $SRC_DIR
    # apply patches
    patch -N -p 1 -i ../${NAME}-${VERSION}-fhs-1.patch
    patch -N -p 1 -i ../${NAME}-${VERSION}-upstream_fix-2.patch

    if [[ ! -f /System/cfg/ld.so.conf ]]; then
        touch /System/cfg/ld.so.conf
    fi

    mkdir -pv build
    pushd build
        echo "rootsbindir=/System/sbin" > configparms

        ../configure --prefix=/System        \
             --sysconfdir=/System/cfg        \
             --disable-werror                \
             --enable-kernel=6.4             \
             --enable-stack-protector=strong \
             libc_cv_slibdir=/System/lib64
        make
        # run the test suite
        # We know that some of these fail right now. Will investigate at a later time
        #    many of the failures are likely coming from being in a chroot and from
        #    subtle changes to the new OS design
        make check ||:

        # Disable a broken guard
        sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile
        make install

        # fix a hard coded path
        sed '/RTLDLIST=/s@/System@@g' -i /usr/bin/ldd

        # install all locales
        make localedata/install-locales
    popd

    if [[ ! -f /System/cfg/nsswitch.conf ]]; then
    # configure the nss layer
    cat > /System/cfg/nsswitch.conf << "EOF"
#
# /etc/nsswitch.conf
#
# An example Name Service Switch config file. This file should be
# sorted with the most-used services at the beginning.
#
# Valid databases are: aliases, ethers, group, gshadow, hosts,
# initgroups, netgroup, networks, passwd, protocols, publickey,
# rpc, services, and shadow.
#
# Valid service provider entries include (in alphabetical order):
#
#       compat                  Use /etc files plus *_compat pseudo-db
#       db                      Use the pre-processed /var/db files
#       dns                     Use DNS (Domain Name Service)
#       files                   Use the local files in /etc
#       hesiod                  Use Hesiod (DNS) for user lookups
#       nis                     Use NIS (NIS version 2), also called YP
#       nisplus                 Use NIS+ (NIS version 3)
#
# See `info libc 'NSS Basics'` for more information.
#
# Commonly used alternative service providers (may need installation):
#
#       ldap                    Use LDAP directory server
#       myhostname              Use systemd host names
#       mymachines              Use systemd machine names
#       mdns*, mdns*_minimal    Use Avahi mDNS/DNS-SD
#       resolve                 Use systemd resolved resolver
#       sss                     Use System Security Services Daemon (sssd)
#       systemd                 Use systemd for dynamic user option
#       winbind                 Use Samba winbind support
#       wins                    Use Samba wins support
#       wrapper                 Use wrapper module for testing
#
# Notes:
#
# 'sssd' performs its own 'files'-based caching, so it should generally
# come before 'files'.
#
# WARNING: Running nscd with a secondary caching service like sssd may
#          lead to unexpected behaviour, especially with how long
#          entries are cached.
#
# Installation instructions:
#
# To use 'db', install the appropriate package(s) (provide 'makedb' and
# libnss_db.so.*), and place the 'db' in front of 'files' for entries
# you want to be looked up first in the databases, like this:
#
# passwd:    db files
# shadow:    db files
# group:     db files

passwd:         compat
group:          compat
shadow:         compat
# Allow initgroups to default to the setting for group.
initgroups:     compat

hosts:          files dns
networks:       files

aliases:        files
ethers:         files
gshadow:        files
netgroup:       files
protocols:      files
publickey:      files
rpc:            files
services:       files
sudoers:        files
automount:      files
bootparams:     files
netmasks:       files
EOF
    fi

    if [[ ! -f /System/share/zoneinfo/zone.tab ]]; then
        # configure TZ data
        pushd build
            tar -xf ../../tzdata2024a.tar.gz

            ZONEINFO=/System/share/zoneinfo
            mkdir -pv $ZONEINFO/{posix,right}

            for tz in etcetera southamerica northamerica europe africa antarctica  \
                      asia australasia backward; do
                zic -L /dev/null   -d $ZONEINFO       ${tz}
                zic -L /dev/null   -d $ZONEINFO/posix ${tz}
                zic -L leapseconds -d $ZONEINFO/right ${tz}
            done

            cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
            zic -d $ZONEINFO -p America/New_York
            unset ZONEINFO
        popd
    fi

    echo
    echo "NOTICE: Remember to set the TZ using the following commands:"
    echo
    echo "tzselect"
    echo "ln -sfv /System/share/zoneinfo/<xxx> /System/cfg/localtime"

    if [[ ! -f /System/cfg/ld.so.conf ]]; then
        # configure the ld library cache
        cat >> /System/cfg/ld.so.conf << "EOF"
# Add an include directory
include /System/cfg/ld.so.conf.d/*.conf
EOF
        mkdir -pv /etc/ld.so.conf.d
        cat >> /System/cfg/ld.so.conf.d/system.conf << "EOF"
/System/lib
/System/lib64
/Applications/Common/lib
/Applications/Common/lib64
/System/local/lib
/System/local/lib64
EOF
    fi
popd

# clean up
rm -rf $SRC_DIR
