#!/usr/bin/env python3
"""비밀 값을 출력하지 않는 논리 백업. 원본/운영 DB를 삭제하지 않는다."""
from pathlib import Path
from datetime import datetime, timezone
import subprocess
root = Path(__file__).resolve().parents[1]
folder = root / '.private/backups'
folder.mkdir(parents=True, exist_ok=True)
folder.chmod(0o700)
result = subprocess.run(['docker', 'compose', '-f', str(root/'deploy/compose.yml'),
    'exec', '-T', 'db', 'sh', '-c', 'pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" -Fc'], capture_output=True)
if result.returncode:
    raise SystemExit('Database backup failed; deployment stopped')
path = folder / (datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ') + '.dump')
path.write_bytes(result.stdout)
path.chmod(0o600)
print('Private database backup saved')
