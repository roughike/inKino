#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

(cd core && pub get)
(cd web && pub get)
(cd mobile && ./flutter/bin/flutter packages get)