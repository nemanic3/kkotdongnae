import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    required double latitude,
    required double longitude,
    String? address,
    DateTime? timestamp,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}

@freezed
class SearchFilters with _$SearchFilters {
  const factory SearchFilters({
    @Default(5000) int radiusMeters,
    String? categoryId,
    String? searchQuery,
    @Default(SortOption.distance) SortOption sortBy,
    @Default(1) int minRating,
    @Default(false) bool openNowOnly,
  }) = _SearchFilters;

  factory SearchFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchFiltersFromJson(json);
}

enum SortOption {
  distance,
  rating,
  reviewCount,
  newest,
}
