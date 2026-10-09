# 꽃동네

Flutter UI와 Django REST API로 구성한 위치 기반 꽃집 탐색 프로젝트입니다. 기존 모바일 스타일 UI를 Flutter 웹으로 빌드하며 로그인·회원가입, 꽃집 목록/상세/검색, 거리 기반 주변 조회, 사용자별 즐겨찾기, 리뷰 작성/조회는 Django PostgreSQL에 연결합니다.

- 공개 프런트엔드 주소: https://kkotdongnae.nemanic.dev
- GitHub: https://github.com/nemanic3/kkotdongnae
- 배포·검증 현황과 복구 방법: [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)
- 홈페이지에 복사할 소개: [docs/NEMANIC_INTRO.md](docs/NEMANIC_INTRO.md)

> 프런트엔드 HTTPS 배포는 완료했지만 공개 API는 Tunnel 승인 대기입니다. 전체 서비스 배포 완료 상태가 아닙니다.

## 현재 구현 범위

| 기능 | 현재 상태 |
|---|---|
| 가입/로그인/토큰 갱신/프로필 | Django JWT 연결. 비밀번호 재설정·이메일 인증은 미구현 |
| 꽃집 목록/검색/상세/주변 거리 | Django 연결. 위치 거부 시 서울 기본 좌표 사용 |
| 지도 | 선택한 꽃집을 네이버 지도 검색으로 열기. 앱 내 지도 SDK는 미구현 |
| 즐겨찾기/텍스트 리뷰 | 사용자별 PostgreSQL 저장. 사진 첨부 미지원 |
| 상품/예약/판매자 API | Django에 구현. 주문 슬롯 동시 예약 검사. Flutter 전체 주문 연동 미완료 |
| 피드/채팅/주문/장바구니 화면 | 기존 데모 화면 유지, 데모 안내 표시. 실제 결제 아님 |
| 결제·AI 이미지 생성 | 외부 서비스 연동 없음. 결제 완료로 바꾸던 모의 API 운영 차단 |
| 업로드·백그라운드 알림 | 파일 업로드 endpoint 및 worker/scheduler 없음. 이미지 URL 필드와 알림/리마인더 기록만 존재 |

README의 과거 AI/결제 소개는 계획을 섞어 설명한 내용이었습니다. 이 문서는 현재 코드의 구현 범위를 기준으로 합니다. Supabase URL/키가 있던 레거시 서비스 import 경로는 보존하되 실제 동작은 Django 어댑터로 교체했습니다. Supabase 서버에 쓰기 작업은 하지 않았습니다.

## 구조

- `flutter_app/lib`: 기존 Flutter 화면, Riverpod, GoRouter, Dio/JWT 저장
- `backend/accounts`, `shops`, `orders`: Django/DRF, PostgreSQL 모델과 API
- `deploy/compose.yml`: Mac mini 운영 DB/API. Django는 Workers에서 실행하지 않음
- `deploy/pages/_worker.js`: Pages Functions의 고정 HTTPS origin proxy
- `.github/workflows/ci.yml`: PostgreSQL/API 테스트, Flutter 검사/화면 테스트/웹 빌드 후 `pages` 브랜치 게시

## 개발 및 검사

Flutter SDK 3.47.2, Python 3.11, PostgreSQL 16을 사용합니다. 운영 비밀 값은 `.private/production.env` 또는 Pages Secrets에 보관하며 Git에 넣지 않습니다.

```sh
cd flutter_app
flutter pub get
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test test/widget_test.dart
cd ..
scripts/build-pages.sh
node --test deploy/pages/proxy.test.mjs
```

백엔드는 비공개 env 설정 후 `docker compose -f deploy/compose.yml`로 실행합니다. 운영 DB는 테스트나 시딩 대상으로 사용하지 마세요. 테스트는 Django가 생성하는 별도 `test_*` DB에서 실행합니다. `DEBUG=1`, 빈 `ORIGIN_PROXY_SECRET`은 격리된 테스트 명령에서만 사용합니다.
