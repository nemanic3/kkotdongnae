# NEMANIC 홈페이지용 소개

꽃동네는 주변 꽃집을 찾아보고 관심 매장을 저장하며 리뷰를 남길 수 있는 위치 기반 꽃집 탐색 프로젝트입니다. Flutter의 기존 모바일 스타일 UI를 웹으로 제공하고, Django REST API와 PostgreSQL로 회원 인증·꽃집 데이터·사용자별 즐겨찾기·텍스트 리뷰를 관리합니다. 피드·채팅·주문 화면은 데모이며 실제 결제와 AI 이미지 생성은 아직 제공하지 않습니다.

주요 기능: 이메일 회원가입/로그인 및 JWT 갱신, 꽃집 검색·상세 조회, 위치와 반경을 이용한 주변 꽃집 검색, 네이버 지도 검색으로 위치 확인, 사용자별 즐겨찾기, 텍스트 리뷰 작성/조회. 상품·예약 슬롯·판매자/주문 관리 API는 백엔드에 구현되어 있습니다.

기술 구성: Flutter/Dart, Riverpod, GoRouter, Dio, Django/DRF/SimpleJWT, PostgreSQL 16, Docker/Gunicorn, Cloudflare Pages/Pages Functions/Tunnel, GitHub Actions. PostGIS 및 실제 AI·결제 연동은 사용하지 않습니다.

서비스: https://kkotdongnae.nemanic.dev (배포 검증 결과는 DEPLOYMENT.md 확인)
GitHub: https://github.com/nemanic3/kkotdongnae

운영 조건: 프런트엔드는 Cloudflare Pages에서 제공하며 API/DB는 Mac mini에서 실행됩니다. Mac mini와 Docker, 네트워크 및 Tunnel이 실행 중이어야 데이터 기능을 사용할 수 있습니다. 재부팅 후 로그인과 Docker 시작이 필요할 수 있으며 결제·AI 생성·파일 업로드·실시간 채팅·백그라운드 알림은 제공하지 않습니다.
