🌸 꽃동네 (Flower Neighborhood)

우리 동네 꽃집을 가장 쉽고 빠르게 찾고, 비교하고, 주문하는 방법

꽃동네는 위치 기반 서비스(Location-Based Service) 를 활용하여
사용자 주변의 꽃집을 탐색하고, 상품을 비교하며, 주문 및 결제까지 한 번에 처리할 수 있는
로컬 화훼 O2O 플랫폼(Online to Offline Platform) 입니다.

기존에 분산되어 있던 꽃 구매 과정을 하나의 흐름으로 통합하여
탐색 → 비교 → 주문 → 결제까지 이어지는 일관된 사용자 경험을 제공합니다.

🚀 Overview

꽃동네는 다음과 같은 기능을 하나의 플랫폼에서 제공합니다.

꽃집 탐색 → 상품 비교 → 주문 및 예약 → 결제
📍 위치 기반 꽃집 탐색
🌼 AI 기반 꽃 상품 미리보기
🛒 주문 및 예약 시스템
🏪 판매자 운영 및 홍보 기능
🧭 프로젝트 배경 (Background)
👤 소비자 관점 문제
SNS, 지도 앱, 메신저 등 여러 플랫폼에 정보가 분산
가격 및 주문 가능 여부를 개별 문의해야 하는 구조
주문 제작 상품 특성상 결과 예측이 어려움
🏪 판매자 관점 문제
온라인 쇼핑몰 구축 및 SNS 운영에 대한 높은 부담
주문이 여러 채널로 분산되어 관리 비효율 발생
온라인 노출 부족으로 지역 고객 확보 어려움

👉 결과적으로
탐색 비용 증가 + 구매 경험 저하 문제가 발생

💡 해결 방향 (Solution)

꽃동네는 소비자와 판매자를 하나의 플랫폼에서 연결하여
다음과 같은 가치를 제공합니다.

빠르고 직관적인 꽃집 탐색
비주얼 중심 상품 비교
주문/예약/결제 통합
AI 기반 구매 경험 강화
판매자 운영 효율화

👉 찾기 쉽고, 비교 쉽고, 주문 쉬운 플랫폼

✨ 주요 기능 (Key Features)
📍 위치 기반 꽃집 탐색
사용자 위치 기반 주변 꽃집 조회
거리, 운영 상태, 당일 주문 가능 여부 확인
지도 기반 매장 위치 표시
포트폴리오 및 리뷰 확인
🌼 AI 기반 꽃 상품 미리보기
스타일, 색감, 예산 입력 → 꽃 이미지 생성
주문 전 결과물 미리보기 제공
커스텀 주문의 불확실성 감소
🛒 주문 및 예약 시스템
픽업 / 배송 방식 선택
날짜 및 시간 예약
요청사항 입력 (문구, 스타일 등)
주문 상태 추적 및 알림
🏪 판매자 플랫폼 기능
매장 정보 등록 및 관리
상품 및 포트폴리오 업로드
SNS 형태 게시글 기능
주문 및 예약 관리
⭐ 개인화 기능
즐겨찾기
최근 본 상품
기념일 리마인드
사용자 기반 추천 시스템
🌿 도메인 특화 설계
✔ 상품 구조 이원화
표준 상품형: 화분, 식물 등 완제품
커스텀 주문형: 꽃다발, 꽃바구니 등 제작형 상품
✔ 제작 가능 슬롯 개념

일반 쇼핑몰의 “재고 수량”이 아닌

👉 시간대별 제작 가능 수량 관리

예:

13:00 ~ 15:00 → 3건 가능
18:00 ~ 20:00 → 2건 가능

→ 실제 꽃집 운영 방식 반영

🏗 System Architecture
Mobile Application
        │
        │ REST API
        ▼
Backend Server
        │
        ▼
Database (PostgreSQL / MySQL)
        │
        ▼
External Services
 ├─ Map API (GIS)
 ├─ Payment API
 └─ Generative AI
🛠 Tech Stack
Frontend
Flutter / React Native
Map API
UI Framework
Backend
Django / RESTful API
Python
Database
PostgreSQL (PostGIS)
Relational Database Modeling
AI
Generative AI Image Model
DevOps / Tools
Docker
GitHub
Cloud Server
CI/CD
📂 Project Structure
flower-neighborhood
│
├── backend
│   ├── api
│   ├── controllers
│   ├── services
│   └── models
│
├── frontend
│   ├── screens
│   ├── components
│   └── assets
│
├── docs
│
└── README.md
📅 개발 로드맵 (Roadmap)
1️⃣ 설계 단계 (3~4월)
요구사항 정의
시스템 아키텍처 설계
개발 환경 구축
2️⃣ 핵심 기능 구현 (5~8월)
사용자 인증
위치 기반 탐색
주문/예약 시스템
판매자 기능
3️⃣ 고도화 단계 (9~10월)
결제 시스템 연동
AI 기능 구현
서비스 안정화
4️⃣ 마무리 단계 (11월)
통합 테스트
배포 및 시연 준비
👥 Team
이름	역할
김건호	Team Leader
신성현	Backend Developer
정희원	Developer
🎯 기대 효과 (Expected Outcomes)
Location-Based Service 구현 경험
RESTful API 설계 및 개발
관계형 데이터베이스 모델링
Generative AI 활용
실제 서비스 수준 아키텍처 설계

👉 로컬 화훼 시장의 디지털 전환 및 활성화 기여

💡 Vision

Flower Neighborhood — Connecting local flower shops with customers
