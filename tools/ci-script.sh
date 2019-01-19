#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

./tools/rename-tmdb-config-file.sh
./tools/get-packages.sh
./tools/analyze-all.sh
./tools/test-all.sh