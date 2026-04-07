// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      shopId: json['shop_id'] as String,
      orderNumber: json['order_number'] as String,
      orderStatus: json['order_status'] as String? ?? 'pending',
      totalAmount: (json['total_amount'] as num).toInt(),
      pickupDate: json['pickup_date'] == null
          ? null
          : DateTime.parse(json['pickup_date'] as String),
      pickupTime: json['pickup_time'] as String?,
      note: json['note'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
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

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'shop_id': instance.shopId,
      'order_number': instance.orderNumber,
      'order_status': instance.orderStatus,
      'total_amount': instance.totalAmount,
      'pickup_date': instance.pickupDate?.toIso8601String(),
      'pickup_time': instance.pickupTime,
      'note': instance.note,
      'items': instance.items,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'shop': instance.shop,
    };

_$OrderItemModelImpl _$$OrderItemModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemModelImpl(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toInt(),
      options: json['options'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$OrderItemModelImplToJson(
  _$OrderItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'order_id': instance.orderId,
  'product_id': instance.productId,
  'name': instance.name,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'options': instance.options,
  'image_url': instance.imageUrl,
};
