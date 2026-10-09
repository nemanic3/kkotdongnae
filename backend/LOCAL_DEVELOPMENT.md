# 백엔드 개발

최신 운영 구성은 [배포 문서](../docs/DEPLOYMENT.md)를 확인하세요.
개발 compose는 비공개 `POSTGRES_PASSWORD`, `DJANGO_SECRET_KEY`가 필요합니다.
DB 포트는 localhost:15432, 개발 API 포트는 localhost:18000입니다.
운영과 기존 DB를 삭제/초기화하지 마세요. `seed_demo`는 DEBUG 환경에서만 실행되며 비공개 `DEMO_PASSWORD`가 필요합니다. 운영에서는 실행하지 않습니다.
Flutter는 Supabase 대신 Django JWT와 REST API를 사용합니다. `API_ORIGIN`은 공개 API 주소만 지정하며 비밀 값은 빌드에 넣지 않습니다.
