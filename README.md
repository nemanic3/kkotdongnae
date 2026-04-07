# 🌸 꽃동네 (Flower Neighborhood)

> **우리 동네 꽃집을 가장 쉽게 찾는 방법**

꽃동네는 **위치 기반(Location-Based Service)** 기술을 활용하여  
사용자 주변의 꽃집을 탐색하고 상품을 비교하며 주문까지 할 수 있는  
**O2O 플랫폼(Online to Offline Platform)** 입니다.

소비자는 하나의 플랫폼에서  

`꽃집 탐색 → 상품 확인 → 주문 및 결제`

까지 편리하게 이용할 수 있으며,  
판매자는 별도의 쇼핑몰이나 SNS 운영 부담 없이 **상품 홍보와 주문 관리**를 할 수 있습니다.

본 프로젝트는 **GIS, RESTful API, Database Modeling, Generative AI** 등  
실제 서비스 수준의 기술을 활용하여 구현하는 것을 목표로 합니다.

---

# 📌 Project Overview

| 항목 | 내용 |
|---|---|
| 프로젝트 이름 | 꽃동네 (Flower Neighborhood) |
| 프로젝트 유형 | Location-Based O2O Platform |
| 개발 목적 | 지역 꽃집과 소비자를 연결하는 플랫폼 구축 |
| 개발 기간 | 2026 졸업 프로젝트 |
| 플랫폼 | Mobile Application + Backend Server |

---

# 🧭 프로젝트 배경 (Background)

현재 꽃을 구매하려는 소비자는 다음과 같은 과정을 거칩니다.

- 인스타그램 / 블로그에서 꽃집 스타일 확인  
- 지도 앱에서 매장 위치 검색  
- 전화 또는 카카오톡으로 가격 문의  
- 예약 가능 여부 확인  

이처럼 **정보가 여러 플랫폼에 분산되어 있어 구매 과정이 비효율적**입니다.

또한 꽃집 판매자는 다음과 같은 어려움을 겪습니다.

- 온라인 쇼핑몰 구축 비용  
- SNS 관리 부담  
- 디지털 판매 환경 부족  

이러한 문제로 인해 **온라인 판매 확장이 어려운 상황**입니다.

꽃동네는 이러한 문제를 해결하기 위해  
**소비자와 판매자를 하나의 플랫폼에서 연결하는 서비스**로 기획되었습니다.

---

# ✨ 주요 기능 (Key Features)

## 📍 위치 기반 꽃집 탐색

사용자의 위치 정보를 기반으로 주변 꽃집을 탐색할 수 있습니다.

**기능**

- 주변 꽃집 검색  
- 지도 기반 매장 위치 표시  
- 매장 운영 상태 확인  
- 판매 상품 정보 조회  

---

## 🌼 AI 기반 꽃 상품 미리보기

**Generative AI**를 활용하여 사용자가 원하는 스타일의 꽃 이미지를 생성합니다.

사용자는 다음과 같은 장점을 얻을 수 있습니다.

- 꽃 디자인 스타일 확인  
- 구매 전 분위기 미리보기  
- 더 높은 구매 만족도  

---

## 🏪 판매자 SNS 기능

꽃집 판매자는 플랫폼 내에서 다음 기능을 사용할 수 있습니다.

- 상품 사진 업로드  
- 홍보 게시글 작성  
- 브랜드 스타일 소개  

즉, **SNS 형태의 홍보 기능**을 제공합니다.

---

## 🛒 주문 및 결제 시스템

플랫폼 내에서 다음 기능을 제공합니다.

- 상품 주문  
- 결제 연동  
- 주문 알림  
- 예약 관리  

이를 통해 판매자는 **별도의 쇼핑몰 없이도 온라인 판매 환경을 운영**할 수 있습니다.

---

# 🏗 System Architecture

```
Mobile Application
        │
        │  REST API
        ▼
Backend Server
        │
        ▼
Database (MySQL / PostgreSQL)
        │
        ▼
External Services
 ├─ Map API (GIS)
 ├─ Payment API
 └─ Generative AI
```

---

# 🛠 Tech Stack

## Frontend
```
Flutter / React Native
Map API
UI Framework
```

## Backend
```
RESTful API
Server Framework
```

## Database
```
MySQL / PostgreSQL
Relational Database Modeling
```

## AI
```
Generative AI Image Model
```

## Tools
```
GitHub
Docker
Cloud Server
```

---

# 📂 Project Structure

```
flower-neighborhood
│
├── backend
│   ├── api
│   ├── models
│   ├── services
│   └── controllers
│
├── frontend
│   ├── screens
│   ├── components
│   └── assets
│
├── docs
│
└── README.md
```

---

# 👥 Team

| 이름 | 역할 |
|---|---|
| 김건호 | Team Leader |
| 신성현 | Developer |
| 정희원 | Developer |

---

# 🎯 기대 효과 (Expected Outcomes)

본 프로젝트를 통해 다음과 같은 역량을 습득할 수 있습니다.

- Location-Based Service 구현 경험  
- RESTful API 설계 및 개발  
- 관계형 데이터베이스 모델링  
- Generative AI 활용 경험  
- 실제 서비스 수준의 시스템 아키텍처 설계  

또한 지역 꽃집과 소비자를 연결하는 플랫폼을 통해  
**로컬 화훼 시장 활성화에 기여하는 것을 목표로 합니다.**

---

💡 **Flower Neighborhood — Connecting local flower shops with customers**