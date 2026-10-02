// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedPostModelImpl _$$FeedPostModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedPostModelImpl(
      id: json['id'] as String,
      shopId: json['shop_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      postType: json['post_type'] as String? ?? 'normal',
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      isLiked: json['is_liked'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      shop: json['shop'] == null
          ? null
          : FlowerShopModel.fromJson(json['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FeedPostModelImplToJson(_$FeedPostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_id': instance.shopId,
      'title': instance.title,
      'content': instance.content,
      'images': instance.images,
      'post_type': instance.postType,
      'like_count': instance.likeCount,
      'comment_count': instance.commentCount,
      'view_count': instance.viewCount,
      'is_liked': instance.isLiked,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'shop': instance.shop,
    };
