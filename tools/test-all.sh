#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo "--- Running tests in core... ---"
(cd core && pub get && pub run test)

echo "--- Running tests in mobile... ---"
(cd mobile && flutter packages get && flutter test)

echo "--- Running tests in web... ---"
(cd web && pub get && pub run build_runner test --fail-on-severe -- -p chrome)