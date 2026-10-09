import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/location_model.dart';
import '../../services/location_service.dart';

// Location permission state
final locationPermissionProvider = FutureProvider<bool>((ref) async {
  return await LocationService.checkAndRequestPermission();
});

// Current location provider
final currentLocationProvider =
    StateNotifierProvider<LocationNotifier, AsyncValue<LocationModel>>((ref) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<AsyncValue<LocationModel>> {
  LocationNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = AsyncValue.data(LocationService.getDefaultLocation());
  }

  Future<void> refreshLocation() async {
    state = const AsyncValue.loading();

    // Try to get last known location first (faster)
    final lastKnown = await LocationService.getLastKnownLocation();
    if (lastKnown != null) {
      state = AsyncValue.data(lastKnown);
    }

    // Then get current location (more accurate)
    final current = await LocationService.getCurrentLocation();
    if (current != null) {
      state = AsyncValue.data(current);
    } else if (lastKnown == null) {
      // Fallback to default location
      state = AsyncValue.data(LocationService.getDefaultLocation());
    }
  }

  void setLocation(LocationModel location) {
    state = AsyncValue.data(location);
  }
}

// Search filters provider
final searchFiltersProvider =
    StateNotifierProvider<SearchFiltersNotifier, SearchFilters>((ref) {
  return SearchFiltersNotifier();
});

class SearchFiltersNotifier extends StateNotifier<SearchFilters> {
  SearchFiltersNotifier() : super(const SearchFilters());

  void updateRadius(int meters) {
    state = state.copyWith(radiusMeters: meters);
  }

  void updateCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
  }

  void updateSearchQuery(String? query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateSortBy(SortOption sortBy) {
    state = state.copyWith(sortBy: sortBy);
  }

  void updateMinRating(int rating) {
    state = state.copyWith(minRating: rating);
  }

  void toggleOpenNowOnly() {
    state = state.copyWith(openNowOnly: !state.openNowOnly);
  }

  void reset() {
    state = const SearchFilters();
  }
}
