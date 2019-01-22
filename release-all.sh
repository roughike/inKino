#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

(cd mobile && flutter build apk && flutter build ios)

(cd mobile/android && fastlane internal)
(cd mobile/ios && fastlane beta)
(cd web && ./deploy.sh && firebase deploy)