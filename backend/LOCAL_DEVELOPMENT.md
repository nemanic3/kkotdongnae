# 로컬 개발 및 Flutter 연동

## 백엔드 실행

```sh
cd /Users/shinsunghyun/Desktop/kkotdongnae-backend
.venv/bin/python manage.py migrate
.venv/bin/python manage.py seed_demo
.venv/bin/python manage.py runserver 127.0.0.1:8000
```

이미 8000번 서버가 실행 중이면 중복 실행하지 않습니다.
DB는 PostgreSQL이며 `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`,
`POSTGRES_HOST`, `POSTGRES_PORT` 환경변수로 로컬 기본값을 재정의할 수 있습니다.
CORS는 `http://localhost:3000`, `http://127.0.0.1:3000`을 허용합니다.

시딩은 가상 꽃집 3곳, 상품 9개, 한국 날짜 기준 오늘부터 7일간 슬롯 189개를
준비합니다. 같은 날 재실행해도 중복 생성하지 않으며 기존 값·비밀번호·예약 수를
덮어쓰지 않습니다. 날짜가 바뀌면 새 날짜의 슬롯만 추가하며 과거 슬롯은 유지합니다.
상품 이미지는 아직 비어 있습니다. 판매자 계정은 로그인 불가로 생성합니다.

체험 로그인: `demo@kkotdongnae.test` / `KkotDemo123!`

```sh
curl http://127.0.0.1:8000/api/shops/
curl http://127.0.0.1:8000/api/shops/1/products/
curl -X POST http://127.0.0.1:8000/api/auth/login/ \
  -H 'Content-Type: application/json' \
  -d '{"email":"demo@kkotdongnae.test","password":"KkotDemo123!"}'
```

꽃집 ID는 목록 응답에서 확인합니다. 로그인 응답의 `tokens.access`를
`Authorization: Bearer <access>`로 보내면 `GET /api/users/me/`를 조회할 수 있습니다.

## Flutter 연결에 필요한 다음 변경

현재 Flutter의 `lib/services/supabase_service.dart`는 원격 Supabase 인증과
PostgREST/RPC를 사용합니다. Django DB 시딩만으로 앱 화면에 데이터가 나타나지는
않습니다. Supabase URL만 Django 주소로 바꾸어도 SDK 프로토콜이 달라 동작하지 않습니다.

화면을 유지하고 서비스 및 인증 provider를 Django HTTP 호출로 전환하는 순서가 적합합니다.

1. API 기본 주소를 `http://127.0.0.1:8000/api/`로 설정합니다.
2. 로그인 서비스를 `POST auth/login/`으로 바꾸고 `tokens.access`, `tokens.refresh`,
   `user`를 처리합니다. `auth_provider.dart`의 Supabase `User`/`AuthState` 의존성도
   앱 인증 상태로 바꿔야 합니다. 회원가입은 `POST auth/signup/`이며
   `email`, `password`, `password_confirm`, `name`, `phone`을 보냅니다.
3. 꽃집 서비스의 목록·상세·주변 조회를 아래 API에 연결합니다.
4. 서비스에서 응답을 기존 `FlowerShopModel`에 맞게 변환합니다.
5. 카테고리·사진 API는 현재 Django에 없으므로 해당 모델/API를 추가하거나
   해당 서비스의 임시 빈 목록 처리를 명시적으로 결정해야 합니다.

| 기능 | Django 요청 |
| --- | --- |
| 꽃집 목록 | `GET shops/` |
| 꽃집 상세 | `GET shops/{id}/` |
| 주변 꽃집 | `GET shops/nearby/?lat=37.4979&lng=127.0276&radius=5` |
| 꽃집 상품 | `GET shops/{id}/products/` |
| 예약 가능 슬롯 | `GET shops/{id}/slots/available/?date=YYYY-MM-DD` |

| Django 응답 | 기존 Flutter 모델 변환 |
| --- | --- |
| 정수 `id` | 문자열 `id` |
| 문자열 `lat`, `lng` | 숫자 `latitude`, `longitude` |
| `distance_km` | 1000을 곱한 `distance_meters` |
| `open_time`, `close_time` | 필요하면 `opening_hours` 표시 형식으로 변환 |

주변 검색의 `radius` 단위는 km이므로 Flutter의 `radiusMeters`를 1000으로 나눕니다.
현재 목록 응답은 JSON 배열이며 카테고리 필터·검색어·페이지네이션은 별도 구현이 필요합니다.

## 확인 상태

2026-09-10: PostgreSQL 마이그레이션 및 시딩 완료. 실제 HTTP로 로그인, JWT 내 정보,
꽃집 목록, 3개 꽃집 상품·예약 슬롯, 주변 검색, localhost:3000 Origin 및 로그인
preflight의 CORS 응답을 검증했습니다. 시딩 재실행 전후 건수도 동일했습니다.
Flutter 코드는 변경하지 않았으며 앱 화면을 통한 종단 간 테스트는 아직 수행하지 않았습니다.
확인 당시 Flutter 3000번 서버는 실행 중이지 않았습니다. 재실행 명령:

```sh
cd /Users/shinsunghyun/Desktop/kkotdongnae
flutter run -d web-server --web-hostname localhost --web-port 3000
```

서비스 전환 후 `http://localhost:3000/#/onboarding`에서 로그인하고,
브라우저 Network 탭에 8000번 API 요청과 200 응답이 나타나는지 확인합니다.
