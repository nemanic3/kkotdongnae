#!/usr/bin/env python3
"""Deploy only main commits whose GitHub verification workflow succeeded."""
import fcntl
import io
import json
from pathlib import Path
import subprocess
import tarfile

root = Path(__file__).resolve().parents[1]
private = root / '.private'
private.mkdir(exist_ok=True)
lock = (private / 'poller.lock').open('w')
try:
    fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
except BlockingIOError:
    raise SystemExit(0)

def run(args, **kwargs):
    return subprocess.run(args, cwd=root, check=True, capture_output=True, timeout=45, **kwargs)

try:
    run(['docker', 'info'])
except (subprocess.CalledProcessError, subprocess.TimeoutExpired):
    raise SystemExit(0)

try:
    run(['docker', 'compose', '-f', 'deploy/compose.yml', 'up', '-d'])
    run(['git', 'fetch', 'origin', 'main'])
    sha = run(['git', 'rev-parse', 'origin/main'], text=True).stdout.strip()
    marker = private / 'deployed-sha'
    if marker.exists() and marker.read_text().strip() == sha:
        raise SystemExit(0)
    runs = json.loads(run(['gh', 'run', 'list', '-R', 'nemanic3/kkotdongnae',
        '--workflow', 'ci.yml', '--commit', sha, '--limit', '1',
        '--json', 'conclusion,headSha,status'], text=True).stdout)
    if not runs or runs[0]['status'] != 'completed' or runs[0]['conclusion'] != 'success':
        raise SystemExit(0)
    release = private / 'releases' / sha
    if not release.exists():
        release.mkdir(parents=True)
        archive = run(['git', 'archive', sha]).stdout
        with tarfile.open(fileobj=io.BytesIO(archive)) as tar:
            for member in tar.getmembers():
                if not (release / member.name).resolve().is_relative_to(release.resolve()) or member.issym() or member.islnk():
                    raise RuntimeError('Unsafe archive')
            tar.extractall(release, filter='data')
        (release / '.private').symlink_to(private, target_is_directory=True)
    subprocess.run(['sh', str(release/'scripts/deploy-backend.sh')], cwd=release,
        check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    marker.write_text(sha+'\n')
    print('Verified backend release deployed:', sha[:12])
except (subprocess.CalledProcessError, subprocess.TimeoutExpired):
    print('Deployment failed; inspect private environment and CI.')
    raise SystemExit(1)
