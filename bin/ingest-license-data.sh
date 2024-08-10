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

LICENSE_DATA=${1:-"$SCRIPT_LIB_DIR/licenses.json"}
DB_FILE=${2:-"$SCRIPT_DB_DIR/lpkg.db"}

# check if license data is a real file
if [[ -f $LICENSE_DATA ]]; then
    say "FILE TO PROCESS: $LICENSE_DATA"
    for LICENSE in $(jq -r ' .licenses|.[]|.licenseId' $LICENSE_DATA); do
        print "LICENSE TO PROCESS: ${LICENSE,,}"
        # check if license name is already in db
        response="$(sqlite3 $DB_FILE "SELECT Name FROM Licenses WHERE Name IS '${LICENSE,,}'")"
        if [[ -z "${response}" ]]; then
            sqlite3 $DB_FILE "INSERT INTO Licenses (Name) VALUES('${LICENSE,,}')"
            print_green " OK" && echo
        else
            print_yellow " skipped" && echo
        fi
    done
fi
