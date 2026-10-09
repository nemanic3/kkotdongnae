#!/bin/sh
set -eu
cd "$(dirname "$0")/../flutter_app"
flutter pub get
flutter build web --release --dart-define=API_ORIGIN=https://kkotdongnae.nemanic.dev
cp ../deploy/pages/_worker.js build/web/_worker.js
printf '%s\n' '{"version":1,"include":["/api/*"],"exclude":[]}' > build/web/_routes.json
printf '%s\n' '/*' '  X-Content-Type-Options: nosniff' '  Referrer-Policy: strict-origin-when-cross-origin' '  Permissions-Policy: camera=(), microphone=(), geolocation=(self)' > build/web/_headers
