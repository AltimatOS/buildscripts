#!/bin/bash

set -e
set -u
set -o pipefail
set -x

pushd /
    ln -svf /proc/self/mounts /System/cfg/mtab
    cat > System/cfg/hosts << EOF
127.0.0.1  localhost
::1        localhost ipv6-localhost ipv6-loopback
fe00::0    ipv6-localnet
ff00::0    ipv6-mcastprefix
ff02::1    ipv6-allnodes
ff02::2    ipv6-allrouters
ff02::3    ipv6-allhosts

EOF

    cat > System/cfg/passwd << "EOF"
root:x:0:0:root:/System/var/root:/System/bin/bash
bin:x:1:1:bin:/dev/null:/System/bin/false
daemon:x:6:6:Daemon User:/dev/null:/System/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/System/var/run/dbus:/System/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/System/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/System/bin/false
EOF

    cat > System/etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF

    localedef -i C -f UTF-8 C.UTF-8

    touch System/var/log/{btmp,lastlog,faillog,wtmp}
    chgrp -v utmp System/var/log/lastlog
    chmod -v 664  System/var/log/lastlog
    chmod -v 600  System/var/log/btmp
popd
