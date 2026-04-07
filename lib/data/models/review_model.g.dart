// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      shopId: json['shop_id'] as String,
      rating: (json['rating'] as num).toInt(),
      content: json['content'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      helpfulCount: (json['helpful_count'] as num?)?.toInt() ?? 0,
      isVisible: json['is_visible'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'shop_id': instance.shopId,
      'rating': instance.rating,
      'content': instance.content,
      'photos': instance.photos,
      'helpful_count': instance.helpfulCount,
      'is_visible': instance.isVisible,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
    };

_$CreateReviewRequestImpl _$$CreateReviewRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateReviewRequestImpl(
  shopId: json['shop_id'] as String,
  rating: (json['rating'] as num).toInt(),
  content: json['content'] as String?,
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$CreateReviewRequestImplToJson(
  _$CreateReviewRequestImpl instance,
) => <String, dynamic>{
  'shop_id': instance.shopId,
  'rating': instance.rating,
  'content': instance.content,
  'photos': instance.photos,
};
