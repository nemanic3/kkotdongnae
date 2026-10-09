// 기존 화면 import 경로를 유지하는 Django 서비스 어댑터.
import '../core/network/api_client.dart';
import '../core/network/token_storage.dart';
import '../data/models/models.dart';

UserModel userFromApi(Map<String, dynamic> data) => UserModel(
  id: data['id'].toString(), email: data['email'],
  displayName: data['name'], phone: data['phone'],
);
FlowerShopModel shopFromApi(Map<String, dynamic> data) => FlowerShopModel(
  id: data['id'].toString(), name: data['name'], address: data['address'],
  latitude: double.parse(data['lat'].toString()),
  longitude: double.parse(data['lng'].toString()),
  phone: data['phone'], description: data['description'],
  isVerified: false,
  distanceMeters: data['distance_km'] == null ? null : (data['distance_km'] as num).toDouble() * 1000,
);
ReviewModel reviewFromApi(Map<String, dynamic> data) => ReviewModel(
  id: data['id'].toString(), userId: data['user'].toString(),
  shopId: data['shop'].toString(), rating: data['rating'],
  content: data['comment'], createdAt: DateTime.tryParse(data['created_at'] ?? ''),
);

class SupabaseService {
  static UserModel? currentUser;
  static bool get isAuthenticated => currentUser != null;
  static Future<void> initialize() async {
    if (await TokenStorage.getAccessToken() == null) return;
    try {
      currentUser = await UserService.getCurrentUserProfile();
    } catch (_) {
      await TokenStorage.clearTokens();
    }
  }
  static Future<UserModel> _authenticate(String path, Map<String, dynamic> body) async {
    final response = await ApiClient.instance.post(path, data: body);
    final data = response.data;
    await TokenStorage.saveTokens(access: data['tokens']['access'], refresh: data['tokens']['refresh']);
    return currentUser = userFromApi(Map<String, dynamic>.from(data['user']));
  }
  static Future<UserModel> signIn({required String email, required String password}) =>
    _authenticate('/api/auth/login/', {'email': email, 'password': password});
  static Future<UserModel> signUp({required String email, required String password, String? displayName}) =>
    _authenticate('/api/auth/signup/', {'email': email, 'password': password,
      'password_confirm': password, 'name': displayName ?? '', 'phone': ''});
  static Future<void> signOut() async {
    try {
      final refresh = await TokenStorage.getRefreshToken();
      if (refresh != null) await ApiClient.instance.post('/api/auth/logout/', data: {'refresh': refresh});
    } catch (_) {
      // 연결 실패 시에도 현재 기기의 세션은 정리한다.
    }
    await TokenStorage.clearTokens();
    currentUser = null;
  }
  static Future<void> resetPassword(String email) async {
    throw Exception('비밀번호 재설정은 아직 제공하지 않습니다.');
  }
}

class ShopService {
  static Future<List<FlowerShopModel>> findNearbyShops({required double latitude,
    required double longitude, int radiusMeters = 5000}) async {
    final response = await ApiClient.instance.get('/api/shops/nearby/', queryParameters: {
      'lat': latitude, 'lng': longitude, 'radius': radiusMeters / 1000,
    });
    return (response.data as List).map((e) => shopFromApi(Map<String, dynamic>.from(e))).toList();
  }
}

class FavoriteService {
  static Future<List<FavoriteModel>> getUserFavorites() async {
    if (!SupabaseService.isAuthenticated) return [];
    final response = await ApiClient.instance.get('/api/favorites/shops/');
    return (response.data as List).map((e) => FavoriteModel(
      id: e['id'].toString(), userId: SupabaseService.currentUser!.id,
      shopId: e['shop']['id'].toString(), shop: shopFromApi(Map<String, dynamic>.from(e['shop'])),
    )).toList();
  }
  static Future<bool> isFavorite(String shopId) async =>
    (await getUserFavorites()).any((f) => f.shopId == shopId);
  static Future<bool> toggleFavorite(String shopId) async {
    if (!SupabaseService.isAuthenticated) throw Exception('로그인이 필요합니다.');
    final isFav = await isFavorite(shopId);
    if (isFav) {
      await ApiClient.instance.dio.delete('/api/favorites/shops/$shopId/delete/');
    } else {
      await ApiClient.instance.post('/api/favorites/shops/$shopId/');
    }
    return !isFav;
  }
}

class ReviewService {
  static Future<List<ReviewModel>> getShopReviews(String shopId, {int pageSize = 10, int offset = 0}) async {
    final response = await ApiClient.instance.get('/api/shops/$shopId/reviews/');
    return (response.data as List).map((e) => reviewFromApi(Map<String, dynamic>.from(e))).skip(offset).take(pageSize).toList();
  }
  static Future<List<ReviewModel>> getUserReviews() async {
    if (!SupabaseService.isAuthenticated) return [];
    final response = await ApiClient.instance.get('/api/users/me/reviews/');
    return (response.data as List).map((e) => reviewFromApi(Map<String, dynamic>.from(e))).toList();
  }
  static Future<ReviewModel> createReview(CreateReviewRequest request) async {
    if (request.photos.isNotEmpty) throw Exception('사진 첨부는 아직 제공하지 않습니다.');
    final response = await ApiClient.instance.post('/api/reviews/', data: {
      'shop': int.parse(request.shopId), 'rating': request.rating, 'comment': request.content ?? '',
    });
    return reviewFromApi(Map<String, dynamic>.from(response.data));
  }
}

class UserService {
  static Future<UserModel?> getCurrentUserProfile() async {
    final response = await ApiClient.instance.get('/api/users/me/');
    return userFromApi(Map<String, dynamic>.from(response.data));
  }
  static Future<UserModel> updateProfile({String? displayName, String? avatarUrl, String? phone}) async {
    if (avatarUrl != null) throw Exception('프로필 사진 업로드는 아직 제공하지 않습니다.');
    final response = await ApiClient.instance.dio.patch('/api/users/me/', data: {
      if (displayName != null) 'name': displayName, if (phone != null) 'phone': phone,
    });
    return SupabaseService.currentUser = userFromApi(Map<String, dynamic>.from(response.data['user']));
  }
}
