# 꽃동네 배포 및 운영

2026-10-10 KST. 실제 검증 결과는 아래 현황에 갱신합니다.

## 구성

Flutter 정적 웹 → Cloudflare Pages. `/api/*` → Pages Functions 고정 origin proxy → Cloudflare Tunnel → Mac mini Docker Gunicorn/Django → PostgreSQL 16. Django 자체는 Pages/Workers에서 실행하지 않습니다.

`kkotdongnae.nemanic.dev`는 Pages, `kkotdongnae-origin.nemanic.dev`는 Tunnel 원본 API용입니다. 원본은 Pages와 공유하는 `ORIGIN_PROXY_SECRET`이 없으면 403입니다. preview/pages.dev에서는 운영 API 접근을 차단합니다. API 응답은 캐시하지 않고 브라우저 쿠키를 origin에 전달하지 않습니다. Django JWT로 사용자 인증하며 데이터 조회를 사용자/판매자 기준으로 제한합니다.

API는 localhost:18080에만 바인딩하고 DB는 호스트 포트를 열지 않습니다. Compose project는 `kkotdongnae-production`, 운영 볼륨은 `kkotdongnae_production_database`. 다른 프로젝트와 포트를 공유하지 않습니다. 원본 `kkotdongnae-backend_postgres_data`와 기존 컨테이너는 유지합니다. PostGIS/Redis/Celery는 현재 코드에 필요하지 않습니다. 거리 계산은 Python haversine입니다. 별도 파일 업로드 저장소가 필요하지 않은 현재 범위를 유지합니다.

## 비밀 값과 환경 변수

| 위치 | 이름 | 용도 |
|---|---|---|
| Mac 비공개 파일 | `DJANGO_SECRET_KEY` | 신규 독립 JWT/Django 서명키 |
| Mac와 Pages Secret | `ORIGIN_PROXY_SECRET` | 원본 API 접근 차단용 신규 난수 |
| Mac | `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_HOST`, `POSTGRES_PORT` | 운영 DB. 비밀번호 신규 난수 |
| Mac | `DEBUG=0`, `ALLOWED_HOSTS`, `CORS_ALLOWED_ORIGINS` | 운영 HTTPS/도메인 제한 |
| Mac | `PAYMENT_ENABLED=0` | 실제 결제 미구현, 반드시 비활성 유지 |
| Pages 운영 변수 | `DJANGO_ORIGIN=https://kkotdongnae-origin.nemanic.dev` | 고정 HTTPS 원본 |
| Flutter 빌드 | `API_ORIGIN=https://kkotdongnae.nemanic.dev` | 공개 주소, 비밀 없음 |
| 개발 시딩만 | `DEMO_PASSWORD` | 임시 계정 비밀번호. 운영 시딩 금지 |

`.private/production.env`는 mode 600, `.private`는 mode 700. 코드/로그/공개 빌드에 비밀을 기록하지 않습니다. 기존 Git 이력에 있던 개발용 값은 삭제하되 이력을 강제 재작성하지 않습니다. 운영에는 새 키/비밀번호를 사용합니다. 비밀번호 재설정·SNS 로그인·AI·결제 API 키는 현재 구현이 없어 설정하지 않습니다.

## 데이터 보존과 백업

원본 DB는 중지 상태에서 읽기 전용 tar 백업 후 별도 운영 볼륨에 복제했습니다. `.private/backups/original-postgres-20261010.tar.gz`와 `.private/backups/pre-deploy.dump`는 개인정보가 포함될 수 있으므로 비공개 보관합니다. 원본 볼륨은 변경하지 않았습니다. 추가 배포 전 `python3 scripts/backup.py`가 논리 백업을 저장합니다.

복구는 API를 중지하고 **새 이름의 볼륨/DB**에 pg_restore로 복원한 뒤 건수·FK·로그인을 확인하고 연결을 전환합니다. 원본/운영 볼륨에 `down -v`, `docker volume rm`, DROP/flush/reset을 실행하지 마세요. 롤백 전에 최근 데이터 백업을 확보합니다. 스키마 롤백은 코드 롤백만으로 해결되지 않을 수 있습니다.

## 자동 배포

GitHub `Verify and publish`는 main의 Django PostgreSQL 테스트와 Flutter 검사를 모두 통과한 경우에만 정적 빌드를 `pages` 브랜치의 `public/`에 게시합니다. Pages는 기존 설치된 GitHub 앱으로 `nemanic3/kkotdongnae`의 `pages` 브랜치를 연결하며 빌드 명령은 비우고 출력은 `public`으로 둡니다. 소스 README/DB/env를 게시하지 않고 검사된 정적 산출물만 배포합니다. PR/preview에서는 운영 API를 차단합니다.

Mac API는 `scripts/deploy-backend.sh`로 백업→빌드→보안 검사→migration→static→시작합니다. 자동 배포 poller는 검사가 성공한 main commit만 독립 release 디렉터리에 체크아웃하고 운영 private env를 사용합니다. 공개 self-hosted GitHub runner는 설치하지 않습니다. 저장소 변경 권한은 서버 코드 실행 권한이므로 main 권한을 관리하세요.

## 재시작·운영 조건

Mac mini가 켜져 있고 네트워크·Docker Desktop·Tunnel이 실행 중이어야 API가 동작합니다. Docker `restart: unless-stopped`는 Docker 엔진이 시작된 뒤에만 적용됩니다. Mac 로그인 전 Docker Desktop 시작, FileVault 잠금 해제, 정전 후 부팅, OS 재부팅 자체는 보장하지 않습니다. 자동 로그인/보안 설정을 변경하지 않습니다. Docker Desktop의 로그인 시 시작 여부를 확인하세요.

```sh
docker compose -f deploy/compose.yml up -d
docker compose -f deploy/compose.yml ps
scripts/deploy-backend.sh
python3 scripts/backup.py
```

launch agent/poller는 로그인 후 Docker 준비를 기다리며 API/DB를 시작하고 성공한 신규 커밋만 배포하도록 준비합니다. 기존 홍익봇 Tunnel을 공유하는 경우 Tunnel 재시작은 홍익봇에도 영향이 있으므로 꽃동네만의 배포에서 이를 재시작하지 않습니다. Tunnel 라우트만 추가하며 기존 hostname 설정을 유지합니다.

## 검증 현황

- 원본 물리 백업 + 복사본 논리 백업 완료.
- 별도 test DB에서 인증/가입/갱신/프로필, 사용자별 즐겨찾기/리뷰/주문 권한, 주변 좌표 오류, 모의 결제 차단 7개 테스트 통과.
- Pages proxy 3개 테스트 통과.
- Flutter 로그인 390×844, 1440×900 화면/입력 검증 2개 테스트 통과. 정적 분석에는 기존 경고/info가 있으며 컴파일 오류 없음.
- Flutter release 웹 빌드 통과.
- 실제 도메인, GitHub CI, 재부팅, 실제 위치·외부 지도는 별도 검증 후 기록. 아직 검증 완료라고 보지 않습니다.

## 공개 배포 현황 (2026-10-10)

- Pages 프로젝트 `kkotdongnae` 생성 완료. GitHub 기존 앱 접근 사용, `pages` 브랜치 / `public` 출력으로 자동 배포. 소스 main preview는 비활성화했습니다.
- `https://kkotdongnae.nemanic.dev` HTTPS 200과 SSL 활성 확인. `release.txt`로 배포 소스 커밋을 확인할 수 있습니다.
- Pages에 `DJANGO_ORIGIN`과 암호화된 `ORIGIN_PROXY_SECRET` 저장 완료. preview에는 운영 secret을 입력하지 않았습니다.
- **공개 API는 미연결:** Tunnel 경로 `kkotdongnae-origin.nemanic.dev → http://host.docker.internal:18080`는 입력만 준비했습니다. 컴퓨터 사용 정책상 로컬 API 공개는 실행 시점 승인 대상이므로 제출하지 않았습니다. 기존 `hongikbot-origin.nemanic.dev → http://api:8000` 경로는 그대로 유지했습니다.
- 원본 DB 사용자/매장/주문은 모두 0건이었습니다. 운영 복사본은 실제 사용자 데이터를 추가하거나 시딩하지 않았습니다. QA는 별도 `kkot_qa` DB·localhost API에 가짜 계정/가상 매장만 사용했습니다. `seed_public_catalog`는 선택적 데모 카탈로그 명령이며 운영에 자동 실행하지 않습니다.
- 실제 브라우저 QA에서 가입→로그인→매장 상세→즐겨찾기 저장→텍스트 리뷰 저장을 확인했고, HTTP로 저장 결과·토큰 폐기·접근 권한을 확인했습니다. 브라우저 검증으로 발견한 찜 탭의 Mock 데이터, 업로드 성공 오인 안내, 가입 이메일 확인 오인 안내를 수정했습니다.
- 공개 도메인에서는 데스크톱 1440×900과 모바일 390×844 로그인 화면만 확인했습니다. 공개 도메인의 가입/로그인/DB 저장은 API 미연결 때문에 **검증하지 못했습니다**. 실제 GPS 권한·네이버 지도 화면·유료 외부 API는 검증하지 않았습니다.
- Mac launch agent 파일 설치/등록 완료: `~/Library/LaunchAgents/dev.nemanic.kkotdongnae.deploy.plist`, 5분 간격. 현재 launchd의 Python 실행은 Desktop의 스크립트 파일 열기 단계에서 대기하고 있어 자동 실행 성공/재부팅 복구는 아직 확인하지 못했습니다. OS 파일 접근 요청이 있다면 운영자가 검토해야 합니다. 권한을 우회하거나 자동 로그인/FileVault 설정을 변경하지 않았습니다.
- 캡처: `docs/screenshots/live-login-desktop.jpg`, `live-login-mobile.jpg`는 실제 도메인. `qa-*`는 격리 localhost QA. `tunnel-pending.jpg`는 제출되지 않은 경로의 승인 화면으로 로컬에만 보관하며 GitHub에 올리지 않습니다. 실제 개인정보/비밀 값은 포함하지 않았습니다.

## 운영자에게 남은 조치

1. 준비된 Tunnel 공개 경로의 최종 승인. 기존 Tunnel credential을 새로 발급/복사/교체하지 않습니다. 승인 후 꽃동네 origin 접근의 403/프록시 health 200을 확인해야 합니다.
2. Mac의 launch agent 파일 접근 대기 원인/권한을 확인하고 Docker Desktop 로그인 시 시작을 확인합니다. 등록 상태 확인: `launchctl print gui/$(id -u)/dev.nemanic.kkotdongnae.deploy`.
3. `python3 scripts/poll-deploy.py` 수동 검사 후 실제 Mac 재부팅/네트워크 복구를 점검합니다. 현재는 재부팅 검증을 주장하지 않습니다.
4. 공개 도메인에서 가짜 계정으로 인증/사용자별 권한/저장/로그아웃을 종단 간 검증한 뒤 전체 서비스 완료로 판단합니다. 실매장 데이터는 운영자가 등록해야 하며 가상 매장을 실제 상점으로 소개하지 않습니다.

참고: [Pages 고급 Functions](https://developers.cloudflare.com/pages/functions/advanced-mode/), [Pages Git 연동](https://developers.cloudflare.com/pages/configuration/git-integration/), [Tunnel macOS 서비스](https://developers.cloudflare.com/tunnel/features/locally-managed-tunnels/as-a-service/macos/), [Django 5.2 지원](https://docs.djangoproject.com/en/5.2/releases/5.2/).
