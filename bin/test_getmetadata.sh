#!/bin/bash

set -e
set -u
set -o pipefail

DEBUG=0

# get our directory
SCRIPT_BIN_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DB_DIR="$SCRIPT_BIN_DIR/../db"
SCRIPT_LIB_DIR="$SCRIPT_BIN_DIR/../lib/lpkgtools"

# import our library functions
source $SCRIPT_LIB_DIR/functions.shlib

# we need to use OUR path not the system one to use our SQLite3 and JQ
PATH="$SCRIPT_BIN_DIR:/bin:/usr/bin"

BP_FILE=${1}

declare -a pkgs=$(get_packages $BP_FILE)

for pkg in $(echo $pkgs); do
    printf "%-16s %s\n" "Name:" $(get_pkg_name $pkg $BP_FILE)
    printf "%-16s %s\n" "Epoch:" $(get_pkg_epoch $pkg $BP_FILE)
    printf "%-16s %s\n" "Version:" $(get_pkg_version $pkg $BP_FILE)
    printf "%-16s %s\n" "License:" $(get_pkg_license $pkg $BP_FILE)
    printf "%-16s %s\n" "URL:" $(get_bld_srcurl $BP_FILE)
    printf "%-16s %s\n" "Section:" $(get_pkg_section $pkg $BP_FILE)
    printf "%-16s %s\n" "Summary:" "$(get_pkg_summary $pkg $BP_FILE)"
    for DEP in $(get_pkg_requires $pkg $BP_FILE); do
        printf "%-16s %s\n" "Requires:" "$DEP"
    done
    for DEP in $(get_build_requires $BP_FILE); do
        printf "%-16s %s\n" "BuildRequires:" "$DEP"
    done
    src_instance=0
    for SRC in $(get_build_srcs $BP_FILE); do
        printf "%-16s %s\n" "Source${src_instance}:" "$SRC"
        ((++src_instance))
    done
    patch_instance=0
    for PATCH in $(get_build_patches $BP_FILE); do
        printf "%-16s %s\n" "Patch${patch_instance}:" "$PATCH"
        ((++patch_instance))
    done
    say "Description:" && get_pkg_description $pkg $BP_FILE
    echo
done
