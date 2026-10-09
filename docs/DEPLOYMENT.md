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

GitHub `Verify and publish`는 main의 Django PostgreSQL 테스트와 Flutter 검사를 모두 통과한 경우에만 정적 빌드를 `pages` 브랜치에 게시합니다. Pages는 기존 설치된 GitHub 앱으로 `nemanic3/kkotdongnae`의 `pages` 브랜치를 연결하며 빌드 명령은 비우고 출력은 `/`로 둡니다. 소스 README/DB/env를 게시하지 않고 검사된 정적 산출물만 배포합니다. PR/preview에서는 운영 API를 차단합니다.

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
