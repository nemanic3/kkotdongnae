import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../services/api_service.dart';
import '../../services/supabase_service.dart';
import 'location_provider.dart';

// Categories provider
final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  return [];
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

  // Django REST API 응답(Map)을 FlowerShopModel로 안전하게 변환
  List<FlowerShopModel> _mapToFlowerShops(List<Map<String, dynamic>> rawList) {
    return rawList.map<FlowerShopModel>((data) {
      try {
        return FlowerShopModel.fromJson({
          'id': data['id']?.toString() ?? '',
          'name': data['name'] ?? '',
          'address': data['road_address'] ?? data['address'] ?? '',
          'latitude': double.tryParse(data['lat']?.toString() ?? '0.0') ?? 0.0,
          'longitude': double.tryParse(data['lng']?.toString() ?? '0.0') ?? 0.0,
          'phone': data['phone'] ?? '',
          'description': data['description'] ?? '',
          'is_verified': data['is_verified'] ?? false,
        });
      } catch (_) {
        return FlowerShopModel(
          id: data['id']?.toString() ?? '',
          name: data['name'] ?? '',
          address: data['road_address'] ?? data['address'] ?? '',
          latitude: double.tryParse(data['lat']?.toString() ?? '0.0') ?? 0.0,
          longitude: double.tryParse(data['lng']?.toString() ?? '0.0') ?? 0.0,
          phone: data['phone'] ?? '',
          description: data['description'] ?? '',
          isVerified: data['is_verified'] ?? false,
        );
      }
    }).toList();
  }

  Future<void> _loadShops() async {
    try {
      _currentPage = 0;
      _hasMore = false;
      _allShops = [];

      final position = location.valueOrNull;
      final shops = position == null
          ? (await ApiService.getShops()).map(shopFromApi).toList()
          : await ShopService.findNearbyShops(latitude: position.latitude,
              longitude: position.longitude, radiusMeters: filters.radiusMeters);

      _allShops = shops;
      state = AsyncValue.data(shops);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _loadShops();
  }

  Future<void> loadMore() async {
    return;
  }

  bool get hasMore => _hasMore;
}

// Selected shop provider
final selectedShopIdProvider = StateProvider<String?>((ref) => null);

// Shop detail provider
final shopDetailProvider =
    FutureProvider.family<FlowerShopModel?, String>((ref, shopId) async {
  final rawShops = await ApiService.getShops();
  final match = rawShops.firstWhere(
    (item) => item['id']?.toString() == shopId,
    orElse: () => <String, dynamic>{},
  );
  if (match.isEmpty) return null;

  try {
    return FlowerShopModel.fromJson({
      'id': match['id']?.toString() ?? '',
      'name': match['name'] ?? '',
      'address': match['road_address'] ?? match['address'] ?? '',
      'latitude': double.tryParse(match['lat']?.toString() ?? '0.0') ?? 0.0,
      'longitude': double.tryParse(match['lng']?.toString() ?? '0.0') ?? 0.0,
      'phone': match['phone'] ?? '',
      'description': match['description'] ?? '',
      'is_verified': match['is_verified'] ?? false,
    });
  } catch (_) {
    return FlowerShopModel(
      id: match['id']?.toString() ?? '',
      name: match['name'] ?? '',
      address: match['road_address'] ?? match['address'] ?? '',
      latitude: double.tryParse(match['lat']?.toString() ?? '0.0') ?? 0.0,
      longitude: double.tryParse(match['lng']?.toString() ?? '0.0') ?? 0.0,
      phone: match['phone'] ?? '',
      description: match['description'] ?? '',
      isVerified: match['is_verified'] ?? false,
    );
  }
});

// Shop photos provider
final shopPhotosProvider =
    FutureProvider.family<List<ShopPhotoModel>, String>((ref, shopId) async {
  return [];
});

// Search results provider
final searchResultsProvider = FutureProvider.family<List<FlowerShopModel>, String>(
    (ref, query) async {
  if (query.isEmpty) return [];
  final rawShops = await ApiService.getShops();
  final filtered = rawShops.where((shop) {
    final name = shop['name']?.toString().toLowerCase() ?? '';
    return name.contains(query.toLowerCase());
  }).toList();

  return filtered.map<FlowerShopModel>((data) {
    try {
      return FlowerShopModel.fromJson({
        'id': data['id']?.toString() ?? '',
        'name': data['name'] ?? '',
        'address': data['road_address'] ?? data['address'] ?? '',
        'latitude': double.tryParse(data['lat']?.toString() ?? '0.0') ?? 0.0,
        'longitude': double.tryParse(data['lng']?.toString() ?? '0.0') ?? 0.0,
        'phone': data['phone'] ?? '',
        'description': data['description'] ?? '',
        'is_verified': data['is_verified'] ?? false,
      });
    } catch (_) {
      return FlowerShopModel(
        id: data['id']?.toString() ?? '',
        name: data['name'] ?? '',
        address: data['road_address'] ?? data['address'] ?? '',
        latitude: double.tryParse(data['lat']?.toString() ?? '0.0') ?? 0.0,
        longitude: double.tryParse(data['lng']?.toString() ?? '0.0') ?? 0.0,
        phone: data['phone'] ?? '',
        description: data['description'] ?? '',
        isVerified: data['is_verified'] ?? false,
      );
    }
  }).toList();
});