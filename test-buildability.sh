#!/bin/bash

set -e
set -u
set -o pipefail

echo 'int main(){}' | $LFS_TGT-gcc -m64 -xc -
readelf -l a.out | grep ld-linux

rm a.out

echo 'int main(){}' | $LFS_TGT-gcc -m32 -xc -
readelf -l a.out | grep '/ld-linux'

rm a.out

