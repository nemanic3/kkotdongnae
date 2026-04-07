// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomModelImpl _$$ChatRoomModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      shopId: json['shop_id'] as String,
      lastMessage: json['last_message'] as String?,
      lastMessageAt: json['last_message_at'] == null
          ? null
          : DateTime.parse(json['last_message_at'] as String),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      shop: json['shop'] == null
          ? null
          : FlowerShopModel.fromJson(json['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatRoomModelImplToJson(_$ChatRoomModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'shop_id': instance.shopId,
      'last_message': instance.lastMessage,
      'last_message_at': instance.lastMessageAt?.toIso8601String(),
      'unread_count': instance.unreadCount,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'shop': instance.shop,
    };

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChatMessageModelImpl(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  senderType: json['sender_type'] as String,
  content: json['content'] as String,
  messageType: json['message_type'] as String? ?? 'text',
  isRead: json['is_read'] as bool? ?? false,
  referenceId: json['reference_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$ChatMessageModelImplToJson(
  _$ChatMessageModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'room_id': instance.roomId,
  'sender_type': instance.senderType,
  'content': instance.content,
  'message_type': instance.messageType,
  'is_read': instance.isRead,
  'reference_id': instance.referenceId,
  'created_at': instance.createdAt?.toIso8601String(),
};
