import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../data/mock/mock_service.dart';

/// 채팅방 목록 Provider
final chatRoomsProvider =
    StateNotifierProvider<ChatRoomsNotifier, AsyncValue<List<ChatRoomModel>>>(
        (ref) {
  return ChatRoomsNotifier();
});

/// 채팅 메시지 Provider
final chatMessagesProvider =
    FutureProvider.family<List<ChatMessageModel>, String>((ref, roomId) async {
  return MockService.getChatMessages(roomId);
});

/// 총 읽지 않은 메시지 수 Provider
final totalUnreadCountProvider = FutureProvider<int>((ref) async {
  return MockService.getTotalUnreadCount();
});

/// 선택된 채팅방 Provider
final selectedChatRoomProvider = StateProvider<ChatRoomModel?>((ref) => null);

/// 채팅방 목록 상태 관리 Notifier
class ChatRoomsNotifier extends StateNotifier<AsyncValue<List<ChatRoomModel>>> {
  ChatRoomsNotifier() : super(const AsyncValue.loading()) {
    loadRooms();
  }

  /// 채팅방 목록 로드
  Future<void> loadRooms() async {
    state = const AsyncValue.loading();

    try {
      final rooms = await MockService.getChatRooms();
      state = AsyncValue.data(rooms);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 새로고침
  Future<void> refresh() async {
    await loadRooms();
  }

  /// 읽음 처리 (특정 채팅방)
  void markAsRead(String roomId) {
    state.whenData((rooms) {
      final updatedRooms = rooms.map((room) {
        if (room.id == roomId) {
          return room.copyWith(unreadCount: 0);
        }
        return room;
      }).toList();
      state = AsyncValue.data(updatedRooms);
    });
  }
}

/// 채팅 메시지 상태 관리 Notifier (실시간 메시지용)
class ChatMessagesNotifier
    extends StateNotifier<AsyncValue<List<ChatMessageModel>>> {
  ChatMessagesNotifier(this.roomId) : super(const AsyncValue.loading()) {
    loadMessages();
  }

  final String roomId;
  final List<ChatMessageModel> _messages = [];

  /// 메시지 로드
  Future<void> loadMessages() async {
    state = const AsyncValue.loading();

    try {
      final messages = await MockService.getChatMessages(roomId);
      _messages.clear();
      _messages.addAll(messages);
      state = AsyncValue.data(List.from(_messages));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 메시지 추가 (로컬)
  void addMessage(ChatMessageModel message) {
    _messages.add(message);
    state = AsyncValue.data(List.from(_messages));
  }
}

/// 채팅방별 메시지 Notifier Provider
final chatMessagesNotifierProvider = StateNotifierProvider.family<
    ChatMessagesNotifier, AsyncValue<List<ChatMessageModel>>, String>(
  (ref, roomId) => ChatMessagesNotifier(roomId),
);
