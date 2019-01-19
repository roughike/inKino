#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Rename tmdb_config.dart.sample file so that the project compiles
(cd core/lib/src && mv tmdb_config.dart.sample tmdb_config.dart)

# Get all packages for core, mobile and web
(cd core && pub get)
(cd web && pub get)
(cd mobile && flutter packages get)

# Analyze core, mobile and web
(cd core && dartanalyzer ./ --fatal-infos --fatal-warnings)
(cd mobile && dartanalyzer ./ --fatal-infos --fatal-warnings)
(cd web && dartanalyzer ./ --fatal-infos --fatal-warnings)

# Run tests for core, mobile and web
echo "--- Running tests in core... ---"
(cd core && pub run test)

echo "--- Running tests in mobile... ---"
(cd mobile && flutter test)

echo "--- Running tests in web... ---"
(cd web && pub run build_runner test --fail-on-severe -- -p chrome)