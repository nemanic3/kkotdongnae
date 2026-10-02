import 'package:freezed_annotation/freezed_annotation.dart';
import 'flower_shop_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

/// 주문 모델
@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'shop_id') required String shopId,
    @JsonKey(name: 'order_number') required String orderNumber,
    /// 주문 상태: pending, confirmed, preparing, ready, completed, cancelled
    @JsonKey(name: 'order_status') @Default('pending') String orderStatus,
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'pickup_date') DateTime? pickupDate,
    @JsonKey(name: 'pickup_time') String? pickupTime,
    String? note,
    @Default([]) List<OrderItemModel> items,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    /// 연결된 가게 정보 (join)
    FlowerShopModel? shop,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

/// 주문 아이템 모델
@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required String id,
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'product_id') required String productId,
    required String name,
    required int quantity,
    @JsonKey(name: 'unit_price') required int unitPrice,
    String? options,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}

/// 주문 상태 enum
enum OrderStatus {
  pending,    // 대기중
  confirmed,  // 확인됨
  preparing,  // 준비중
  ready,      // 준비완료
  completed,  // 완료
  cancelled,  // 취소됨
}

/// 주문 상태 확장
extension OrderStatusExtension on String {
  String get orderStatusLabel {
    switch (this) {
      case 'pending':
        return '주문 대기';
      case 'confirmed':
        return '주문 확인';
      case 'preparing':
        return '준비 중';
      case 'ready':
        return '픽업 대기';
      case 'completed':
        return '완료';
      case 'cancelled':
        return '취소됨';
      default:
        return '알 수 없음';
    }
  }
}
