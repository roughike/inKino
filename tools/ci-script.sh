#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

./rename-tmdb-config-file.sh
./analyze-all.sh
./test-all.sh