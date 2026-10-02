import 'package:freezed_annotation/freezed_annotation.dart';
import 'flower_shop_model.dart';

part 'feed_model.freezed.dart';
part 'feed_model.g.dart';

/// 피드 게시글 모델
@freezed
class FeedPostModel with _$FeedPostModel {
  const factory FeedPostModel({
    required String id,
    @JsonKey(name: 'shop_id') required String shopId,
    required String title,
    String? content,
    @Default([]) List<String> images,
    /// 게시글 타입: normal, event, new_arrival, promotion
    @JsonKey(name: 'post_type') @Default('normal') String postType,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'comment_count') @Default(0) int commentCount,
    @JsonKey(name: 'view_count') @Default(0) int viewCount,
    @JsonKey(name: 'is_liked') @Default(false) bool isLiked,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    /// 연결된 가게 정보 (join)
    FlowerShopModel? shop,
  }) = _FeedPostModel;

  factory FeedPostModel.fromJson(Map<String, dynamic> json) =>
      _$FeedPostModelFromJson(json);
}

/// 피드 필터 타입
enum FeedFilter {
  all,      // 전체
  nearby,   // 내 주변
  favorite, // 찜한 가게
}
