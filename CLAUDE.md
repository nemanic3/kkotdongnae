# Claude 작업 규칙 및 프로젝트 가이드

## 작업 규칙

### 필수 준수 사항
- 여러 작업을 요청받으면 **가장 작은 단위로 분할**
- **한 번에 하나씩** 실행 후 휴먼 개발자의 컨펌을 받음
- 컨펌 없이 다음 작업으로 넘어가지 않음

---

## 프로젝트 개요

- **프로젝트명**: 꽃동네 (kkotdongnae)
- **설명**: 위치 기반 꽃가게 찾기 앱
- **Flutter SDK**: 3.10.4+
- **Dart SDK**: 3.0.0+

---

## 아키텍처

### 하이브리드 Clean Architecture

```
lib/
├── main.dart                 # 앱 진입점
├── core/                     # 공통/핵심 기능
│   ├── constants/            # 앱 전역 상수
│   ├── router/               # GoRouter 설정
│   ├── theme/                # 테마 (색상, 폰트)
│   └── utils/                # 유틸리티 함수
├── data/                     # 데이터 계층
│   ├── models/               # Freezed 데이터 모델
│   ├── datasources/          # 데이터 소스
│   └── repositories/         # 저장소
├── domain/                   # 도메인 계층
│   ├── entities/             # 도메인 엔티티
│   └── usecases/             # 유스케이스
├── presentation/             # 프레젠테이션 계층
│   ├── providers/            # Riverpod 상태 관리
│   ├── screens/              # 화면 페이지
│   └── widgets/              # 재사용 위젯
└── services/                 # 비즈니스 로직 & 외부 API
    ├── supabase_service.dart
    └── location_service.dart
```

---

## 상태 관리

### Riverpod 2.5.1

**Provider 타입별 사용**:
- `Provider`: 간단한 동기 값
- `StreamProvider`: 스트림 데이터 (Auth 상태 등)
- `FutureProvider`: 비동기 데이터
- `FutureProvider.family`: 매개변수 있는 비동기
- `StateNotifierProvider`: 상태 + 메서드

**위젯 타입**:
- `ConsumerWidget`: 상태 관리가 필요한 간단한 위젯
- `ConsumerStatefulWidget`: 로컬 상태가 필요한 복잡한 위젯

---

## 라우팅

### GoRouter 14.2.0

**라우트 구조**:
```
/ (Root)
├── /onboarding
├── /login
├── /signup
├── /home (바텀 네비게이션)
├── /search
├── /shop/:shopId
│   └── /write-review
└── /error
```

**네비게이션 사용**:
- `context.go('/path')`: 교체
- `context.push('/path')`: 스택 추가

---

## 코드 스타일

### 네이밍 컨벤션

| 유형 | 패턴 | 예시 |
|------|------|------|
| 파일명 | snake_case | `home_screen.dart` |
| Screen | `{name}_screen.dart` | `login_screen.dart` |
| Widget | `{name}_widget.dart` | `shop_card.dart` |
| Model | `{name}_model.dart` | `user_model.dart` |
| Provider | `{name}_provider.dart` | `auth_provider.dart` |
| Service | `{name}_service.dart` | `location_service.dart` |
| 클래스명 | PascalCase | `HomeScreen` |

### 포맷팅

- **들여쓰기**: 2 spaces
- **trailing comma**: 사용
- **줄 길이**: ~120자

### Import 순서

```dart
// 1. 패키지 import
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 2. 상대 경로 import
import '../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';

// 3. part (생성 파일)
part 'model.freezed.dart';
part 'model.g.dart';
```

### 주석

- **언어**: 한국어
- **문서 주석**: `///` 사용
- **섹션 구분**: `// 설명` 사용

---

## 테마/스타일

### Material 3

**클래스 구조**:
- `AppColors`: 색상 상수
- `AppTheme`: 테마 정의
- `AppTextStyles`: 텍스트 스타일
- `AppSpacing`: 스페이싱 상수

**기본값**:
- Primary: `#E91E63` (꽃 분홍색)
- Secondary: `#4CAF50` (잎 초록색)
- borderRadius: `12`

---

## 주요 패키지

| 패키지 | 용도 |
|--------|------|
| `flutter_riverpod` | 상태 관리 |
| `go_router` | 라우팅 |
| `supabase_flutter` | 백엔드 (Auth, DB) |
| `freezed` | immutable 모델 생성 |
| `json_serializable` | JSON 직렬화 |
| `geolocator` | GPS 위치 |
| `google_maps_flutter` | 지도 표시 |
| `cached_network_image` | 이미지 캐싱 |
| `hive_flutter` | 로컬 DB |

---

## 코드 생성

**빌드 명령어**:
```bash
dart run build_runner build
```

**사용 라이브러리**:
- Freezed: immutable 데이터 모델
- JSON Serializable: fromJson/toJson

---

## 에러 처리 패턴

```dart
asyncValue.when(
  data: (data) { /* 성공 */ },
  loading: () => CircularProgressIndicator(),
  error: (e, _) => Text('오류: $e'),
);
```
