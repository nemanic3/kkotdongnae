import 'package:freezed_annotation/freezed_annotation.dart';
import 'flower_shop_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

/// 채팅방 모델
@freezed
class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'shop_id') required String shopId,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_message_at') DateTime? lastMessageAt,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    /// 연결된 가게 정보 (join)
    FlowerShopModel? shop,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}

/// 채팅 메시지 모델
@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    /// 발신자 타입: user, shop
    @JsonKey(name: 'sender_type') required String senderType,
    required String content,
    /// 메시지 타입: text, image, product, order
    @JsonKey(name: 'message_type') @Default('text') String messageType,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    /// 상품 또는 주문 연결 ID (product, order 타입일 때)
    @JsonKey(name: 'reference_id') String? referenceId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}

/// 발신자 타입
enum SenderType {
  user,
  shop,
}

/// 메시지 타입
enum MessageType {
  text,
  image,
  product,
  order,
}
