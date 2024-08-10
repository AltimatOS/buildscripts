#!/bin/bash

set -e
set -u
set -o pipefail

# get our directory
SCRIPT_BIN_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DB_DIR="$SCRIPT_BIN_DIR/../db"
SCRIPT_LIB_DIR="$SCRIPT_BIN_DIR/../lib"

LICENSE_DATA=${1:-"$SCRIPT_LIB_DIR/lpkgtools/licenses.json"}
DB_FILE=${2:-"$SCRIPT_DB_DIR/lpkg.db"}

# check if license data is a real file
if [[ -f $LICENSE_DATA ]]; then
    echo "FILE TO PROCESS: $LICENSE_DATA"
    for LICENSE in $(jq -r ' .licenses|.[]|.licenseId' $SCRIPT_LIB_DIR/lpkgtools/licenses.json); do
        echo "LICENSE TO PROCESS: ${LICENSE,,}"
        # check if license name is already in db
        response="$(sqlite3 $DB_FILE "SELECT Name FROM Licenses WHERE Name IS '${LICENSE,,}'")"
        if [[ -z "${response}" ]]; then
            sqlite3 $DB_FILE "INSERT INTO Licenses (Name) VALUES('${LICENSE,,}')"
        fi
    done
fi
