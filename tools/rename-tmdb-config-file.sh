#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

(cd core/lib/src && mv tmdb_config.dart.sample tmdb_config.dart)