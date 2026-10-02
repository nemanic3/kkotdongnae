import 'dart:math';
import '../models/models.dart';
import 'mock_data.dart';

/// 목업 서비스 클래스
/// 실제 API 호출 대신 목업 데이터를 반환합니다.
class MockService {
  MockService._();

  static final Random _random = Random();

  /// 네트워크 지연 시뮬레이션 (200~500ms)
  static Future<void> _simulateDelay() async {
    final delay = 200 + _random.nextInt(300);
    await Future.delayed(Duration(milliseconds: delay));
  }

  // ============================================================
  // Shop 관련 메서드
  // ============================================================

  /// 주변 꽃집 조회
  static Future<List<FlowerShopModel>> findNearbyShops({
    double? latitude,
    double? longitude,
    int? radiusMeters,
    String? categoryId,
    String? searchQuery,
    int page = 0,
    int pageSize = 20,
  }) async {
    await _simulateDelay();

    var result = List<FlowerShopModel>.from(MockData.shops);

    // 검색어 필터링
    if (searchQuery != null && searchQuery.isNotEmpty) {
      result = result.where((shop) {
        return shop.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            (shop.description?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);
      }).toList();
    }

    // 거리 계산 (실제로는 위경도 기반 계산 필요)
    if (latitude != null && longitude != null) {
      result = result.map((shop) {
        final distance = _calculateDistance(
          latitude,
          longitude,
          shop.latitude,
          shop.longitude,
        );
        return shop.copyWith(distanceMeters: distance);
      }).toList();

      // 거리순 정렬
      result.sort((a, b) =>
          (a.distanceMeters ?? 0).compareTo(b.distanceMeters ?? 0));
    }

    // 페이지네이션
    final startIndex = page * pageSize;
    if (startIndex >= result.length) return [];

    final endIndex = min(startIndex + pageSize, result.length);
    return result.sublist(startIndex, endIndex);
  }

  /// 두 지점 간 거리 계산 (Haversine 공식)
  static double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371000.0; // 미터

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  static double _toRadians(double degrees) => degrees * pi / 180;

  /// 꽃집 상세 조회
  static Future<FlowerShopModel?> getShopById(String shopId) async {
    await _simulateDelay();
    try {
      return MockData.shops.firstWhere((shop) => shop.id == shopId);
    } catch (_) {
      return null;
    }
  }

  /// 카테고리 목록 조회
  static Future<List<CategoryModel>> getCategories() async {
    await _simulateDelay();
    return MockData.categories;
  }

  // ============================================================
  // Product 관련 메서드
  // ============================================================

  /// 특정 가게의 상품 목록 조회
  static Future<List<ProductModel>> getShopProducts(String shopId) async {
    await _simulateDelay();
    return MockData.shopProducts[shopId] ?? [];
  }

  // ============================================================
  // Feed 관련 메서드
  // ============================================================

  /// 피드 목록 조회
  static Future<List<FeedPostModel>> getFeedPosts({
    FeedFilter filter = FeedFilter.all,
    int page = 0,
    int pageSize = 10,
  }) async {
    await _simulateDelay();

    var result = MockData.feedPosts;

    // 필터링
    switch (filter) {
      case FeedFilter.nearby:
        // 실제로는 위치 기반 필터링 필요
        break;
      case FeedFilter.favorite:
        result = result
            .where((post) => MockData.favoriteShopIds.contains(post.shopId))
            .toList();
        break;
      case FeedFilter.all:
        break;
    }

    // 최신순 정렬
    result.sort((a, b) {
      final aTime = a.createdAt ?? DateTime(2000);
      final bTime = b.createdAt ?? DateTime(2000);
      return bTime.compareTo(aTime);
    });

    // 페이지네이션
    final startIndex = page * pageSize;
    if (startIndex >= result.length) return [];

    final endIndex = min(startIndex + pageSize, result.length);
    return result.sublist(startIndex, endIndex);
  }

  // ============================================================
  // Order 관련 메서드
  // ============================================================

  /// 주문 목록 조회
  static Future<List<OrderModel>> getOrders({
    int page = 0,
    int pageSize = 10,
  }) async {
    await _simulateDelay();

    final result = List<OrderModel>.from(MockData.orders);

    // 최신순 정렬
    result.sort((a, b) {
      final aTime = a.createdAt ?? DateTime(2000);
      final bTime = b.createdAt ?? DateTime(2000);
      return bTime.compareTo(aTime);
    });

    // 페이지네이션
    final startIndex = page * pageSize;
    if (startIndex >= result.length) return [];

    final endIndex = min(startIndex + pageSize, result.length);
    return result.sublist(startIndex, endIndex);
  }

  /// 주문 상세 조회
  static Future<OrderModel?> getOrderById(String orderId) async {
    await _simulateDelay();
    try {
      return MockData.orders.firstWhere((order) => order.id == orderId);
    } catch (_) {
      return null;
    }
  }

  // ============================================================
  // Chat 관련 메서드
  // ============================================================

  /// 채팅방 목록 조회
  static Future<List<ChatRoomModel>> getChatRooms() async {
    await _simulateDelay();

    final result = List<ChatRoomModel>.from(MockData.chatRooms);

    // 최신 메시지 순 정렬
    result.sort((a, b) {
      final aTime = a.lastMessageAt ?? DateTime(2000);
      final bTime = b.lastMessageAt ?? DateTime(2000);
      return bTime.compareTo(aTime);
    });

    return result;
  }

  /// 채팅 메시지 목록 조회
  static Future<List<ChatMessageModel>> getChatMessages(String roomId) async {
    await _simulateDelay();
    return MockData.chatMessages[roomId] ?? [];
  }

  /// 총 읽지 않은 메시지 수
  static Future<int> getTotalUnreadCount() async {
    await _simulateDelay();
    return MockData.chatRooms.fold<int>(0, (sum, room) => sum + room.unreadCount);
  }

  // ============================================================
  // Favorite 관련 메서드
  // ============================================================

  /// 찜한 가게 목록 조회
  static Future<List<FlowerShopModel>> getFavoriteShops() async {
    await _simulateDelay();
    return MockData.favoriteShops;
  }

  /// 찜 여부 확인
  static Future<bool> isFavorite(String shopId) async {
    await _simulateDelay();
    return MockData.favoriteShopIds.contains(shopId);
  }

  // ============================================================
  // Review 관련 메서드
  // ============================================================

  /// 특정 가게의 리뷰 목록 조회
  static Future<List<ReviewModel>> getShopReviews(
    String shopId, {
    int page = 0,
    int pageSize = 10,
  }) async {
    await _simulateDelay();

    final result = MockData.reviews
        .where((review) => review.shopId == shopId)
        .toList();

    // 최신순 정렬
    result.sort((a, b) {
      final aTime = a.createdAt ?? DateTime(2000);
      final bTime = b.createdAt ?? DateTime(2000);
      return bTime.compareTo(aTime);
    });

    // 페이지네이션
    final startIndex = page * pageSize;
    if (startIndex >= result.length) return [];

    final endIndex = min(startIndex + pageSize, result.length);
    return result.sublist(startIndex, endIndex);
  }

  // ============================================================
  // User 관련 메서드
  // ============================================================

  /// 현재 사용자 정보 조회
  static Future<UserModel> getCurrentUser() async {
    await _simulateDelay();
    return MockData.currentUser;
  }
}
