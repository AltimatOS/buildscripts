#!/bin/bash

set -e
set -u
set -o pipefail
set -x

sudo chown --from builder -R root:root $LFS/{System,tools}
