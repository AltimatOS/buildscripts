#!/bin/bash

set -e
set -u
set -o pipefail
set -x

# applications
for DIR in Applications \
           Applications/Common \
           Applications/Common/bin \
           Applications/Common/lib \
           Applications/Common/lib64 \
           Applications/Common/share; do
    sudo install -v -d -m 755 -o root -g root $LFS/$DIR
done
# system
for DIR in System \
           System/bin \
           System/boot \
           System/cfg \
           System/include \
           System/lib \
           System/lib/firmware \
           System/lib/locale \
           System/lib64 \
           System/libexec \
           System/selinux \
           System/share \
           System/var \
           System/src; do
    sudo install -v -d -m 755 -o root -g root $LFS/$DIR
done
# system/share
for DIR in System/share/color \
           System/share/dict \
           System/share/doc \
           System/share/info \
           System/share/locale \
           System/share/man \
           System/share/man/man1 \
           System/share/man/man2 \
           System/share/man/man3 \
           System/share/man/man4 \
           System/share/man/man5 \
           System/share/man/man6 \
           System/share/man/man7 \
           System/share/man/man8 \
           System/share/misc \
           System/share/terminfo \
           System/share/zoneinfo; do
    sudo install -v -d -m 755 -o root -g root $LFS/$DIR
done
for DIR in System/local \
           System/local/bin \
           System/local/include \
           System/local/lib \
           System/local/lib64 \
           System/local/sbin \
           System/local/share \
           System/local/share/color \
           System/local/share/dict \
           System/local/share/doc \
           System/local/share/info \
           System/local/share/locale \
           System/local/share/man \
           System/local/share/man/man1 \
           System/local/share/man/man2 \
           System/local/share/man/man3 \
           System/local/share/man/man4 \
           System/local/share/man/man5 \
           System/local/share/man/man6 \
           System/local/share/man/man7 \
           System/local/share/man/man8 \
           System/local/share/misc \
           System/local/share/terminfo \
           System/local/share/zoneinfo; do
    sudo install -v -d -m 755 $LFS/$DIR
done
for DIR in Users Users/Shared Volumes Volumes/floppy Volumes/cdrom; do
    sudo install -v -d -m 755 $LFS/$DIR
done

# system/var
for DIR in System/var \
           System/var/adm \
           System/var/cache \
           System/var/crash \
           System/var/lib \
           System/var/lib/color \
           System/var/lib/empty \
           System/var/lib/locate \
           System/var/lib/misc \
           System/var/local \
           System/var/log \
           System/var/mail \
           System/var/opt \
           System/var/spool \
           System/var/run \
           System/var/srv; do
    sudo install -v -d -m 755 -o root -g root $LFS/$DIR
done
# cfg -> etc and tmp -> var/tmp symlinks
pushd $LFS/System
    if [[ ! -L etc ]]; then
        sudo ln -svf cfg $LFS/System/etc
    fi
    if [[ ! -L tmp ]]; then
        sudo ln -svf var/tmp $LFS/System/tmp
    fi
    if [[ ! -L var/lock ]]; then
        sudo ln -svf var/run/lock $LFS/System/var/lock
    fi
popd

sudo install -v -d -m 700 -o root -g root $LFS/System/var/private
sudo install -v -d -m 1777 -o root -g root $LFS/System/var/tmp

# symlinks
pushd $LFS
    if [[ ! -L usr ]]; then
        sudo ln -svf System/ $LFS/usr
    fi
    if [[ ! -L bin ]]; then
        sudo ln -svf System/bin/ $LFS/bin
    fi
    if [[ ! -L boot ]]; then
        sudo ln -svf System/boot/ $LFS/boot
    fi
    if [[ ! -L etc ]]; then
        sudo ln -svf System/cfg/ $LFS/etc
    fi
    if [[ ! -L home ]]; then
        sudo ln -svf Users $LFS/home
    fi
    if [[ ! -L lib ]]; then
        sudo ln -svf System/lib/ $LFS/lib
    fi
    if [[ ! -L lib64 ]]; then
        sudo ln -svf System/lib64/ $LFS/lib64
    fi
    if [[ ! -L sbin ]]; then
        sudo ln -svf System/sbin/ $LFS/sbin
    fi
    if [[ ! -L var ]]; then
        sudo ln -svf System/var/ $LFS/var
    fi
    if [[ ! -L run ]]; then
        sudo ln -svf System/var/run/ $LFS/run
    fi
    if [[ ! -L srv ]]; then
        sudo ln -svf System/var/srv/ $LFS/srv
    fi
    if [[ ! -L tmp ]]; then
        sudo ln -svf System/var/tmp/ $LFS/tmp
    fi
popd

# ensure root home directory has the right permissions
sudo install -v -d -m 750 -o root -g root $LFS/System/var/root
