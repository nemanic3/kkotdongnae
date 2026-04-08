# 🌸 꽃동네 (Flower Neighborhood)

![GitHub repo size](https://img.shields.io/github/repo-size/your-repo/flower-neighborhood)
![GitHub stars](https://img.shields.io/github/stars/your-repo/flower-neighborhood?style=social)
![GitHub license](https://img.shields.io/github/license/your-repo/flower-neighborhood)
![Platform](https://img.shields.io/badge/platform-mobile-blue)
![Tech](https://img.shields.io/badge/stack-Django%20%7C%20Flutter-green)

> 우리 동네 꽃집을 가장 쉽고 빠르게 찾고, 비교하고, 주문하는 방법

꽃동네는 **위치 기반 서비스(Location-Based Service)** 를 활용하여  
사용자 주변의 꽃집을 탐색하고, 상품을 비교하며, 주문 및 결제까지 한 번에 처리할 수 있는  
**로컬 화훼 O2O 플랫폼(Online to Offline Platform)** 입니다.

기존에 분산되어 있던 꽃 구매 과정을 하나의 흐름으로 통합하여  
**탐색 → 비교 → 주문 → 결제**까지 이어지는 일관된 사용자 경험을 제공합니다.

---

## 📸 Demo

> (여기에 앱 화면 이미지 또는 GIF 추가)

![demo](./docs/demo.gif)

---

## 🚀 Overview

`꽃집 탐색 → 상품 비교 → 주문 및 예약 → 결제`

- 📍 위치 기반 꽃집 탐색  
- 🌼 AI 기반 꽃 상품 미리보기  
- 🛒 주문 및 예약 시스템  
- 🏪 판매자 운영 및 홍보 기능  

---

## 🧭 프로젝트 배경 (Background)

### 👤 소비자 관점 문제
- SNS, 지도 앱, 메신저 등 정보가 분산
- 가격 및 주문 가능 여부를 개별 문의해야 하는 구조
- 주문 제작 상품 특성상 결과 예측이 어려움

### 🏪 판매자 관점 문제
- 온라인 쇼핑몰 및 SNS 운영 부담
- 주문 채널 분산 → 관리 비효율
- 온라인 노출 부족 → 고객 확보 어려움

👉 **탐색 비용 증가 + 구매 경험 저하**

---

## 💡 해결 방향 (Solution)

- 빠르고 직관적인 꽃집 탐색
- 비주얼 중심 상품 비교
- 주문/예약/결제 통합
- AI 기반 구매 경험 강화
- 판매자 운영 효율화

👉 **찾기 쉽고, 비교 쉽고, 주문 쉬운 플랫폼**

---

## ✨ 주요 기능 (Key Features)

### 📍 위치 기반 꽃집 탐색
- 사용자 위치 기반 주변 꽃집 조회
- 거리, 운영 상태, 당일 주문 가능 여부 확인
- 지도 기반 위치 표시
- 포트폴리오 및 리뷰 확인

### 🌼 AI 기반 꽃 상품 미리보기
- 스타일, 색감, 예산 입력 → 이미지 생성
- 주문 전 결과 미리보기
- 커스텀 주문 불확실성 감소

### 🛒 주문 및 예약 시스템
- 픽업 / 배송 선택
- 날짜 및 시간 예약
- 요청사항 입력
- 주문 상태 추적

### 🏪 판매자 플랫폼
- 매장 정보 관리
- 상품 및 포트폴리오 등록
- SNS 형태 게시글 기능
- 주문 및 예약 관리

### ⭐ 개인화 기능
- 즐겨찾기
- 최근 본 상품
- 기념일 리마인드
- 추천 시스템

---

## 🌿 도메인 특화 설계

### ✔ 상품 구조 이원화
- 표준 상품형 (화분 등)
- 커스텀 주문형 (꽃다발 등)

### ✔ 제작 가능 슬롯
재고가 아닌 시간 기반 주문 관리

예시:
- 13:00 ~ 15:00 → 3건
- 18:00 ~ 20:00 → 2건

---

## 🏗 System Architecture

```text
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
Backend
Django (Python)
RESTful API
Database
PostgreSQL + PostGIS
AI
Generative AI (Image)
DevOps
Docker
GitHub Actions (CI/CD)
Cloud Server
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
⚙️ Getting Started
1. Clone
git clone https://github.com/your-repo/flower-neighborhood.git
cd flower-neighborhood
2. Backend 실행
cd backend
pip install -r requirements.txt
python manage.py runserver
3. Frontend 실행
cd frontend
npm install
npm start
🔗 API Example
GET /api/shops/nearby?lat=37.55&lng=126.92
[
  {
    "name": "홍대 꽃집",
    "distance": "0.5km",
    "available": true
  }
]
📅 개발 로드맵
1️⃣ 설계 (3~4월)
요구사항 정의
아키텍처 설계
2️⃣ 핵심 개발 (5~8월)
인증
탐색 기능
주문 시스템
3️⃣ 고도화 (9~10월)
결제
AI 기능
4️⃣ 마무리 (11월)
테스트
배포
👥 Team
이름	역할
김건호	Team Leader
신성현	Backend Developer
정희원	Developer
🎯 기대 효과
LBS 서비스 구현 경험
REST API 설계
DB 모델링
AI 서비스 적용

👉 로컬 화훼 시장 디지털 전환 기여

📌 Future Work
추천 시스템 고도화
리뷰 및 평점 기능
정기 구독 서비스
관리자 대시보드
📄 License

MIT License

💡 Vision

Flower Neighborhood — Connecting local flower shops with customers
