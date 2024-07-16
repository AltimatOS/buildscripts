#!/bin/bash

set -e
set -u
set -o pipefail

if [[ "$(zcat /proc/config.gz | grep CONFIG_IA32_EMULATION= | cut -f2 -d'=')" != "y" ]]; then
    echo "Incompatible architecture"
    exit 1
else
    echo "Compatible build host architecture, IA32 Emulation, detected"
    exit 0
fi
if [[ "$(zcat /proc/config.gz | grep CONFIG_X86_X32 | cut -f2 -d'=')" != "y" ]]; then
    echo "Incompatible architecture"
    exit 1
else
    echo "Sufficient build host architecture detected"
    exit 0
fi

