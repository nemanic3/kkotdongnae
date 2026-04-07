import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'shop_id') required String shopId,
    required int rating,
    String? content,
    @Default([]) List<String> photos,
    @JsonKey(name: 'helpful_count') @Default(0) int helpfulCount,
    @JsonKey(name: 'is_visible') @Default(true) bool isVisible,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    // Joined user data
    UserModel? user,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

@freezed
class CreateReviewRequest with _$CreateReviewRequest {
  const factory CreateReviewRequest({
    @JsonKey(name: 'shop_id') required String shopId,
    required int rating,
    String? content,
    @Default([]) List<String> photos,
  }) = _CreateReviewRequest;

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestFromJson(json);
}
