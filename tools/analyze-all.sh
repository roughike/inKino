#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

(cd core && dartanalyzer ./ --fatal-infos --fatal-warnings)
(cd mobile && dartanalyzer ./ --fatal-infos --fatal-warnings)
(cd web && dartanalyzer ./ --fatal-infos --fatal-warnings)