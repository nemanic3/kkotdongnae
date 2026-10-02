import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/constants/app_constants.dart';
import '../data/models/models.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  }

  // Auth Methods
  static User? get currentUser => client.auth.currentUser;
  static bool get isAuthenticated => currentUser != null;
  static Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  // Sign up with email
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': displayName},
    );
  }

  // Sign in with email
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign in with OAuth (Google, Apple, etc.)
  static Future<bool> signInWithOAuth(OAuthProvider provider) async {
    return await client.auth.signInWithOAuth(provider);
  }

  // Sign out
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  // Password reset
  static Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }
}

class ShopService {
  static final _client = SupabaseService.client;

  // Find nearby shops using PostGIS function
  static Future<List<FlowerShopModel>> findNearbyShops({
    required double latitude,
    required double longitude,
    int radiusMeters = 5000,
    String? categoryId,
    String? searchQuery,
    int pageSize = 20,
    int offset = 0,
  }) async {
    final response = await _client.rpc(
      'find_nearby_shops',
      params: {
        'user_lat': latitude,
        'user_lng': longitude,
        'radius_meters': radiusMeters,
        'category_filter': categoryId,
        'search_query': searchQuery,
        'page_size': pageSize,
        'page_offset': offset,
      },
    );

    return (response as List)
        .map((json) => FlowerShopModel.fromJson(json))
        .toList();
  }

  // Get shop by ID with full details
  static Future<FlowerShopModel?> getShopById(String shopId) async {
    final response = await _client
        .from('flower_shops')
        .select()
        .eq('id', shopId)
        .single();

    return FlowerShopModel.fromJson(response);
  }

  // Get shop photos
  static Future<List<ShopPhotoModel>> getShopPhotos(String shopId) async {
    final response = await _client
        .from('shop_photos')
        .select()
        .eq('shop_id', shopId)
        .order('sort_order');

    return (response as List)
        .map((json) => ShopPhotoModel.fromJson(json))
        .toList();
  }

  // Get all categories
  static Future<List<CategoryModel>> getCategories() async {
    final response = await _client
        .from('categories')
        .select()
        .order('sort_order');

    return (response as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }

  // Get shops by category
  static Future<List<FlowerShopModel>> getShopsByCategory(
    String categoryId, {
    int pageSize = 20,
    int offset = 0,
  }) async {
    final response = await _client
        .from('flower_shops')
        .select('''
          *,
          shop_categories!inner(category_id)
        ''')
        .eq('shop_categories.category_id', categoryId)
        .eq('is_active', true)
        .order('average_rating', ascending: false)
        .range(offset, offset + pageSize - 1);

    return (response as List)
        .map((json) => FlowerShopModel.fromJson(json))
        .toList();
  }

  // Search shops by name
  static Future<List<FlowerShopModel>> searchShops(
    String query, {
    int pageSize = 20,
    int offset = 0,
  }) async {
    final response = await _client
        .from('flower_shops')
        .select()
        .ilike('name', '%$query%')
        .eq('is_active', true)
        .order('average_rating', ascending: false)
        .range(offset, offset + pageSize - 1);

    return (response as List)
        .map((json) => FlowerShopModel.fromJson(json))
        .toList();
  }
}

class FavoriteService {
  static final _client = SupabaseService.client;

  // Get user's favorites
  static Future<List<FavoriteModel>> getUserFavorites() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return [];

    final response = await _client
        .from('favorites')
        .select('''
          *,
          flower_shops(*)
        ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => FavoriteModel.fromJson(json))
        .toList();
  }

  // Check if shop is favorited
  static Future<bool> isFavorite(String shopId) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return false;

    final response = await _client
        .from('favorites')
        .select('id')
        .eq('user_id', userId)
        .eq('shop_id', shopId)
        .maybeSingle();

    return response != null;
  }

  // Add to favorites
  static Future<void> addFavorite(String shopId) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client.from('favorites').insert({
      'user_id': userId,
      'shop_id': shopId,
    });
  }

  // Remove from favorites
  static Future<void> removeFavorite(String shopId) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client
        .from('favorites')
        .delete()
        .eq('user_id', userId)
        .eq('shop_id', shopId);
  }

  // Toggle favorite
  static Future<bool> toggleFavorite(String shopId) async {
    final isFav = await isFavorite(shopId);
    if (isFav) {
      await removeFavorite(shopId);
      return false;
    } else {
      await addFavorite(shopId);
      return true;
    }
  }

  // Subscribe to favorites changes (realtime)
  static RealtimeChannel subscribeFavorites(
    void Function(List<FavoriteModel>) onData,
  ) {
    final userId = SupabaseService.currentUser?.id;

    return _client
        .channel('favorites_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'favorites',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) async {
            final favorites = await getUserFavorites();
            onData(favorites);
          },
        )
        .subscribe();
  }
}

class ReviewService {
  static final _client = SupabaseService.client;

  // Get reviews for a shop
  static Future<List<ReviewModel>> getShopReviews(
    String shopId, {
    int pageSize = 10,
    int offset = 0,
  }) async {
    final response = await _client
        .from('reviews')
        .select('''
          *,
          user:users(*)
        ''')
        .eq('shop_id', shopId)
        .eq('is_visible', true)
        .order('created_at', ascending: false)
        .range(offset, offset + pageSize - 1);

    return (response as List)
        .map((json) => ReviewModel.fromJson(json))
        .toList();
  }

  // Get user's reviews
  static Future<List<ReviewModel>> getUserReviews() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return [];

    final response = await _client
        .from('reviews')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ReviewModel.fromJson(json))
        .toList();
  }

  // Create a review
  static Future<ReviewModel> createReview(CreateReviewRequest request) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _client
        .from('reviews')
        .insert({
          'user_id': userId,
          'shop_id': request.shopId,
          'rating': request.rating,
          'content': request.content,
          'photos': request.photos,
        })
        .select()
        .single();

    return ReviewModel.fromJson(response);
  }

  // Update a review
  static Future<ReviewModel> updateReview(
    String reviewId, {
    int? rating,
    String? content,
    List<String>? photos,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (rating != null) updates['rating'] = rating;
    if (content != null) updates['content'] = content;
    if (photos != null) updates['photos'] = photos;

    final response = await _client
        .from('reviews')
        .update(updates)
        .eq('id', reviewId)
        .select()
        .single();

    return ReviewModel.fromJson(response);
  }

  // Delete a review
  static Future<void> deleteReview(String reviewId) async {
    await _client.from('reviews').delete().eq('id', reviewId);
  }

  // Mark review as helpful
  static Future<void> markHelpful(String reviewId) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client.from('review_votes').insert({
      'user_id': userId,
      'review_id': reviewId,
    });
  }

  // Check if user has voted helpful
  static Future<bool> hasVotedHelpful(String reviewId) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return false;

    final response = await _client
        .from('review_votes')
        .select('review_id')
        .eq('user_id', userId)
        .eq('review_id', reviewId)
        .maybeSingle();

    return response != null;
  }
}

class UserService {
  static final _client = SupabaseService.client;

  // Get current user profile
  static Future<UserModel?> getCurrentUserProfile() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return null;

    final response = await _client
        .from('users')
        .select()
        .eq('id', userId)
        .single();

    return UserModel.fromJson(response);
  }

  // Update user profile
  static Future<UserModel> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? phone,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (displayName != null) updates['display_name'] = displayName;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    if (phone != null) updates['phone'] = phone;

    final response = await _client
        .from('users')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserModel.fromJson(response);
  }
}
