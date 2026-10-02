import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../services/supabase_service.dart';

// User favorites provider
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, AsyncValue<List<FavoriteModel>>>(
        (ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<AsyncValue<List<FavoriteModel>>> {
  FavoritesNotifier() : super(const AsyncValue.loading()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    if (!SupabaseService.isAuthenticated) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      final favorites = await FavoriteService.getUserFavorites();
      state = AsyncValue.data(favorites);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _loadFavorites();
  }

  Future<bool> toggleFavorite(String shopId) async {
    try {
      final result = await FavoriteService.toggleFavorite(shopId);
      await _loadFavorites(); // Refresh the list
      return result;
    } catch (e) {
      rethrow;
    }
  }
}

// Check if specific shop is favorited
final isFavoriteProvider =
    FutureProvider.family<bool, String>((ref, shopId) async {
  return await FavoriteService.isFavorite(shopId);
});

// Favorite shop IDs for quick lookup
final favoriteShopIdsProvider = Provider<Set<String>>((ref) {
  final favorites = ref.watch(favoritesProvider);
  return favorites.maybeWhen(
    data: (list) => list.map((f) => f.shopId).toSet(),
    orElse: () => {},
  );
});
