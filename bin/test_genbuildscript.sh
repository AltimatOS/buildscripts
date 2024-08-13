#!/bin/bash

set -e
set -u
set -o pipefail

DEBUG=0

# get our directory
WORKING_DIRECTORY=$(pwd)
SCRIPT_BIN_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DB_DIR="$SCRIPT_BIN_DIR/../db"
SCRIPT_LIB_DIR="$SCRIPT_BIN_DIR/../lib/lpkgtools"

# import our library functions
source $SCRIPT_LIB_DIR/functions.shlib

# we need to use OUR path not the system one to use our SQLite3 and JQ
PATH="$SCRIPT_BIN_DIR:/bin:/usr/bin"

BP_FILE=${1:-}
if [[ -z $BP_FILE ]]; then
    print_error "ERROR: $BP_FILE: File not found! Exiting" && echo
    exit 2
fi

case $BP_FILE in
    /*) abs_path=1 ;;
    *)  abs_path=0 ;;
esac

if [[ "$abs_path" -eq 0 ]]; then
    BP_FILE="$WORKING_DIRECTORY/$BP_FILE"
fi
prep_script=$(generate_prep_script $BP_FILE)
config_script=$(generate_config_script $BP_FILE)
build_script=$(generate_build_script $BP_FILE)

cat $build_script

$prep_script
$config_script
$build_script

rm $prep_script
rm $config_script
rm $build_script
