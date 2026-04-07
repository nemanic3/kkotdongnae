import 'package:freezed_annotation/freezed_annotation.dart';
import 'flower_shop_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

/// 장바구니 모델
@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    @JsonKey(name: 'shop_id') String? shopId,
    @Default([]) List<CartItemModel> items,
    /// 연결된 가게 정보
    FlowerShopModel? shop,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}

/// 장바구니 아이템 모델
@freezed
class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    required String id,
    @JsonKey(name: 'product_id') required String productId,
    required String name,
    required int quantity,
    @JsonKey(name: 'unit_price') required int unitPrice,
    String? options,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}

/// CartModel 확장 메서드
extension CartModelExtension on CartModel {
  /// 총 금액 계산
  int get totalAmount {
    return items.fold(0, (sum, item) => sum + (item.unitPrice * item.quantity));
  }

  /// 총 상품 수
  int get totalItemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  /// 장바구니가 비었는지 확인
  bool get isEmpty => items.isEmpty;
}
