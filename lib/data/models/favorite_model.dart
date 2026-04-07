import 'package:freezed_annotation/freezed_annotation.dart';
import 'flower_shop_model.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

@freezed
class FavoriteModel with _$FavoriteModel {
  const factory FavoriteModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'shop_id') required String shopId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    // Joined shop data
    @JsonKey(name: 'flower_shops') FlowerShopModel? shop,
  }) = _FavoriteModel;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);
}
