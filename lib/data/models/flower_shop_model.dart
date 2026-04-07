import 'package:freezed_annotation/freezed_annotation.dart';

part 'flower_shop_model.freezed.dart';
part 'flower_shop_model.g.dart';

@freezed
class FlowerShopModel with _$FlowerShopModel {
  const factory FlowerShopModel({
    required String id,
    required String name,
    String? description,
    required String address,
    String? addressDetail,
    String? phone,
    String? website,
    String? instagram,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'opening_hours') Map<String, String>? openingHours,
    @JsonKey(name: 'is_open_now') @Default(true) bool isOpenNow,
    @JsonKey(name: 'price_range') @Default(2) int priceRange,
    @JsonKey(name: 'average_rating') @Default(0.0) double averageRating,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
    @JsonKey(name: 'favorite_count') @Default(0) int favoriteCount,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'distance_meters') double? distanceMeters,
    @JsonKey(name: 'primary_photo_url') String? primaryPhotoUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _FlowerShopModel;

  factory FlowerShopModel.fromJson(Map<String, dynamic> json) =>
      _$FlowerShopModelFromJson(json);
}

@freezed
class ShopPhotoModel with _$ShopPhotoModel {
  const factory ShopPhotoModel({
    required String id,
    @JsonKey(name: 'shop_id') required String shopId,
    required String url,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    String? caption,
    @JsonKey(name: 'is_primary') @Default(false) bool isPrimary,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ShopPhotoModel;

  factory ShopPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$ShopPhotoModelFromJson(json);
}
