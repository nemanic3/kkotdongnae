import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../services/supabase_service.dart';
import 'location_provider.dart';

// Categories provider
final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  return await ShopService.getCategories();
});

// Nearby shops provider
final nearbyShopsProvider =
    StateNotifierProvider<NearbyShopsNotifier, AsyncValue<List<FlowerShopModel>>>(
        (ref) {
  final location = ref.watch(currentLocationProvider);
  final filters = ref.watch(searchFiltersProvider);
  return NearbyShopsNotifier(ref, location, filters);
});

class NearbyShopsNotifier
    extends StateNotifier<AsyncValue<List<FlowerShopModel>>> {
  final Ref ref;
  final AsyncValue<LocationModel> location;
  final SearchFilters filters;
  int _currentPage = 0;
  bool _hasMore = true;
  List<FlowerShopModel> _allShops = [];

  NearbyShopsNotifier(this.ref, this.location, this.filters)
      : super(const AsyncValue.loading()) {
    _loadShops();
  }

  Future<void> _loadShops() async {
    location.when(
      data: (loc) async {
        try {
          _currentPage = 0;
          _hasMore = true;
          _allShops = [];

          final shops = await ShopService.findNearbyShops(
            latitude: loc.latitude,
            longitude: loc.longitude,
            radiusMeters: filters.radiusMeters,
            categoryId: filters.categoryId,
            searchQuery: filters.searchQuery,
            pageSize: 20,
            offset: 0,
          );

          _allShops = shops;
          _hasMore = shops.length >= 20;
          state = AsyncValue.data(shops);
        } catch (e, st) {
          state = AsyncValue.error(e, st);
        }
      },
      loading: () => state = const AsyncValue.loading(),
      error: (e, st) => state = AsyncValue.error(e, st),
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _loadShops();
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    final loc = location.valueOrNull;
    if (loc == null) return;

    try {
      _currentPage++;
      final shops = await ShopService.findNearbyShops(
        latitude: loc.latitude,
        longitude: loc.longitude,
        radiusMeters: filters.radiusMeters,
        categoryId: filters.categoryId,
        searchQuery: filters.searchQuery,
        pageSize: 20,
        offset: _currentPage * 20,
      );

      _hasMore = shops.length >= 20;
      _allShops = [..._allShops, ...shops];
      state = AsyncValue.data(_allShops);
    } catch (e) {
      _currentPage--;
    }
  }

  bool get hasMore => _hasMore;
}

// Selected shop provider
final selectedShopIdProvider = StateProvider<String?>((ref) => null);

// Shop detail provider
final shopDetailProvider =
    FutureProvider.family<FlowerShopModel?, String>((ref, shopId) async {
  return await ShopService.getShopById(shopId);
});

// Shop photos provider
final shopPhotosProvider =
    FutureProvider.family<List<ShopPhotoModel>, String>((ref, shopId) async {
  return await ShopService.getShopPhotos(shopId);
});

// Search results provider
final searchResultsProvider = FutureProvider.family<List<FlowerShopModel>, String>(
    (ref, query) async {
  if (query.isEmpty) return [];
  return await ShopService.searchShops(query);
});
