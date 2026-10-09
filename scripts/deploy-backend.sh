#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
# 이전 실행 중복 방지. git working tree는 변경하지 않는다.
mkdir .private/deploy.lock 2>/dev/null || exit 0
trap 'rmdir .private/deploy.lock' EXIT
python3 scripts/backup.py
docker compose -f deploy/compose.yml build api
docker compose -f deploy/compose.yml run --rm api python manage.py check --deploy --fail-level ERROR
docker compose -f deploy/compose.yml run --rm api python manage.py migrate --noinput
docker compose -f deploy/compose.yml run --rm api python manage.py collectstatic --noinput
docker compose -f deploy/compose.yml up -d api
