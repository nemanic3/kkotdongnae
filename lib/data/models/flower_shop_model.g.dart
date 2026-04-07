// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flower_shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlowerShopModelImpl _$$FlowerShopModelImplFromJson(
  Map<String, dynamic> json,
) => _$FlowerShopModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  address: json['address'] as String,
  addressDetail: json['addressDetail'] as String?,
  phone: json['phone'] as String?,
  website: json['website'] as String?,
  instagram: json['instagram'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  openingHours: (json['opening_hours'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  isOpenNow: json['is_open_now'] as bool? ?? true,
  priceRange: (json['price_range'] as num?)?.toInt() ?? 2,
  averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
  favoriteCount: (json['favorite_count'] as num?)?.toInt() ?? 0,
  isVerified: json['is_verified'] as bool? ?? false,
  isActive: json['is_active'] as bool? ?? true,
  distanceMeters: (json['distance_meters'] as num?)?.toDouble(),
  primaryPhotoUrl: json['primary_photo_url'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$FlowerShopModelImplToJson(
  _$FlowerShopModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'address': instance.address,
  'addressDetail': instance.addressDetail,
  'phone': instance.phone,
  'website': instance.website,
  'instagram': instance.instagram,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'opening_hours': instance.openingHours,
  'is_open_now': instance.isOpenNow,
  'price_range': instance.priceRange,
  'average_rating': instance.averageRating,
  'review_count': instance.reviewCount,
  'favorite_count': instance.favoriteCount,
  'is_verified': instance.isVerified,
  'is_active': instance.isActive,
  'distance_meters': instance.distanceMeters,
  'primary_photo_url': instance.primaryPhotoUrl,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

_$ShopPhotoModelImpl _$$ShopPhotoModelImplFromJson(Map<String, dynamic> json) =>
    _$ShopPhotoModelImpl(
      id: json['id'] as String,
      shopId: json['shop_id'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      caption: json['caption'] as String?,
      isPrimary: json['is_primary'] as bool? ?? false,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ShopPhotoModelImplToJson(
  _$ShopPhotoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'shop_id': instance.shopId,
  'url': instance.url,
  'thumbnail_url': instance.thumbnailUrl,
  'caption': instance.caption,
  'is_primary': instance.isPrimary,
  'sort_order': instance.sortOrder,
  'created_at': instance.createdAt?.toIso8601String(),
};
