#!/bin/bash

set -e
set -u
set -o pipefail
set -x

rm -rf /System/share/{info,man,doc}/*

find /System/{lib,lib64,libexec} -name \*.la -delete

# now we no longer need the tools tree
rm -rf /tools
