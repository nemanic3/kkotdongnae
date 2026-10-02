// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationModelImpl _$$LocationModelImplFromJson(Map<String, dynamic> json) =>
    _$LocationModelImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LocationModelImplToJson(_$LocationModelImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$SearchFiltersImpl _$$SearchFiltersImplFromJson(Map<String, dynamic> json) =>
    _$SearchFiltersImpl(
      radiusMeters: (json['radiusMeters'] as num?)?.toInt() ?? 5000,
      categoryId: json['categoryId'] as String?,
      searchQuery: json['searchQuery'] as String?,
      sortBy:
          $enumDecodeNullable(_$SortOptionEnumMap, json['sortBy']) ??
          SortOption.distance,
      minRating: (json['minRating'] as num?)?.toInt() ?? 1,
      openNowOnly: json['openNowOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$$SearchFiltersImplToJson(_$SearchFiltersImpl instance) =>
    <String, dynamic>{
      'radiusMeters': instance.radiusMeters,
      'categoryId': instance.categoryId,
      'searchQuery': instance.searchQuery,
      'sortBy': _$SortOptionEnumMap[instance.sortBy]!,
      'minRating': instance.minRating,
      'openNowOnly': instance.openNowOnly,
    };

const _$SortOptionEnumMap = {
  SortOption.distance: 'distance',
  SortOption.rating: 'rating',
  SortOption.reviewCount: 'reviewCount',
  SortOption.newest: 'newest',
};
